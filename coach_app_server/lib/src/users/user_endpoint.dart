import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class UserEndpoint extends Endpoint {
  Future<User?> getUser(Session session, int userId) {
    return User.db.findById(session, userId);
  }

  Future<User?> register(Session session, User user) async {
    final normalizedContact = user.contact.trim().toLowerCase();
    final normalizedName = user.name.trim();
    if (normalizedContact.isEmpty || normalizedName.isEmpty) return null;

    final existingUser = await User.db.findFirstRow(
      session,
      where: (t) => t.contact.equals(normalizedContact),
    );

    if (existingUser != null) return null;

    final password = user.password.trim();
    if (password.isEmpty) return null;

    final userToInsert = user.copyWith(
      name: normalizedName,
      contact: normalizedContact,
      password: _hashPassword(password),
    );
    return User.db.insertRow(session, userToInsert);
  }

  Future<User?> login(
    Session session,
    String contact,
    String password,
  ) async {
    final normalizedContact = contact.trim().toLowerCase();
    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.contact.equals(normalizedContact),
    );
    if (user == null || !_passwordMatches(password, user.password)) return null;

    if (_isPasswordHash(user.password)) return user;
    return User.db.updateRow(
      session,
      user.copyWith(password: _hashPassword(password)),
    );
  }

  Future<User?> updateProfile(
    Session session,
    int userId,
    String height,
    String weight,
    String age,
  ) async {
    final user = await User.db.findById(session, userId);
    if (user == null) return null;
    final normalizedWeight = weight.trim();

    final updatedUser = user.copyWith(
      height: height.trim().isEmpty ? null : height.trim(),
      weight: normalizedWeight.isEmpty ? null : normalizedWeight,
      age: age.trim().isEmpty ? null : age.trim(),
    );

    final savedUser = await User.db.updateRow(session, updatedUser);
    await _saveBodyWeightIfNeeded(session, userId, normalizedWeight);

    return savedUser;
  }

  Future<User?> updateAccount(
    Session session,
    int userId,
    String name,
    String contact,
  ) async {
    final user = await User.db.findById(session, userId);
    if (user == null) return null;

    final normalizedContact = contact.trim().toLowerCase();
    if (normalizedContact.isEmpty || name.trim().isEmpty) return null;

    if (normalizedContact != user.contact) {
      final existingUser = await User.db.findFirstRow(
        session,
        where: (t) => t.contact.equals(normalizedContact),
      );
      if (existingUser != null && existingUser.id != userId) return null;
    }

    return User.db.updateRow(
      session,
      user.copyWith(
        name: name.trim(),
        contact: normalizedContact,
      ),
    );
  }

  Future<User?> uploadProfileImage(
    Session session,
    int userId,
    String fileName,
    String base64Data,
  ) async {
    final user = await User.db.findById(session, userId);
    if (user == null) return null;

    final bytes = base64Decode(base64Data);
    final storedFileName = _buildStoredAvatarName(userId, fileName);
    final uploadDirectory = Directory('web/static/uploads/avatars');
    if (!uploadDirectory.existsSync()) {
      uploadDirectory.createSync(recursive: true);
    }

    final file = File('${uploadDirectory.path}/$storedFileName');
    await file.writeAsBytes(bytes, flush: true);
    await _deleteStoredAvatar(user.imagePath);

    return User.db.updateRow(
      session,
      user.copyWith(
        imagePath: 'uploads/avatars/$storedFileName',
        imageScale: 1,
        imageOffsetX: 0,
        imageOffsetY: 0,
      ),
    );
  }

  Future<User?> removeProfileImage(Session session, int userId) async {
    final user = await User.db.findById(session, userId);
    if (user == null) return null;

    await _deleteStoredAvatar(user.imagePath);
    return User.db.updateRow(
      session,
      user.copyWith(
        imagePath: null,
        imageScale: null,
        imageOffsetX: null,
        imageOffsetY: null,
      ),
    );
  }

  Future<User?> updateProfileImageFrame(
    Session session,
    int userId,
    double scale,
    double offsetX,
    double offsetY,
  ) async {
    final user = await User.db.findById(session, userId);
    if (user == null || user.imagePath == null) return user;

    return User.db.updateRow(
      session,
      user.copyWith(
        imageScale: scale.clamp(0.5, 4).toDouble(),
        imageOffsetX: offsetX,
        imageOffsetY: offsetY,
      ),
    );
  }

  Future<List<BodyWeightEntry>> listBodyWeights(
    Session session,
    int userId,
  ) async {
    final entries = await BodyWeightEntry.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.measuredAt,
    );

    entries.sort((a, b) => a.measuredAt.compareTo(b.measuredAt));
    return entries;
  }

  Future<void> _saveBodyWeightIfNeeded(
    Session session,
    int userId,
    String weight,
  ) async {
    final parsedWeight = double.tryParse(weight.replaceAll(',', '.'));
    if (parsedWeight == null || parsedWeight <= 0) return;

    final now = DateTime.now().toUtc();
    final entries = await BodyWeightEntry.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.measuredAt,
      orderDescending: true,
      limit: 1,
    );

    if (entries.isNotEmpty) {
      final latest = entries.first;
      final sameDay =
          latest.measuredAt.year == now.year &&
          latest.measuredAt.month == now.month &&
          latest.measuredAt.day == now.day;
      final sameWeight = (latest.weight - parsedWeight).abs() < 0.01;
      if (sameDay && sameWeight) return;
    }

    await BodyWeightEntry.db.insertRow(
      session,
      BodyWeightEntry(
        userId: userId,
        weight: parsedWeight,
        measuredAt: now,
      ),
    );
  }

  String _buildStoredAvatarName(int userId, String fileName) {
    final extension = _safeExtension(fileName);
    final stamp = DateTime.now().microsecondsSinceEpoch;
    return 'avatar_${userId}_$stamp$extension';
  }

  String _safeExtension(String fileName) {
    final trimmed = fileName.trim().toLowerCase();
    final dotIndex = trimmed.lastIndexOf('.');
    if (dotIndex < 0 || dotIndex == trimmed.length - 1) return '.jpg';

    final extension = trimmed.substring(dotIndex);
    final isSafe = RegExp(r'^\.[a-z0-9]{1,8}$').hasMatch(extension);
    return isSafe ? extension : '.jpg';
  }

  Future<void> _deleteStoredAvatar(String? imagePath) async {
    if (imagePath == null || !imagePath.startsWith('uploads/avatars/')) return;
    if (imagePath.contains('..')) return;

    final file = File('web/static/$imagePath');
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {
      // The profile must remain editable even if an old local demo file is gone.
    }
  }

  String _hashPassword(String password) {
    final normalizedPassword = password.trim();
    final bytes = utf8.encode('coach_app_demo_salt_v1:$normalizedPassword');
    return 'sha256:v1:${sha256.convert(bytes)}';
  }

  bool _passwordMatches(String password, String storedPassword) {
    if (_isPasswordHash(storedPassword)) {
      return storedPassword == _hashPassword(password);
    }

    return storedPassword == password.trim();
  }

  bool _isPasswordHash(String password) {
    return password.startsWith('sha256:v1:');
  }
}
