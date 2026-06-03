import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';
import 'main.dart';
import 'offline_cache.dart';
import 'profile_avatar_editor.dart';
import 'profile_image_actions.dart';
import 'server_request.dart';
import 'user_cache.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();
  final _avatarKey = GlobalKey<EditableProfileAvatarState>();

  bool _isAvatarDragging = false;
  bool _isLoading = true;
  bool _showSaveButton = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();

    for (final controller in [
      _nameController,
      _contactController,
      _heightController,
      _weightController,
      _ageController,
    ]) {
      controller.addListener(_onFieldChanged);
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _nameController,
      _contactController,
      _heightController,
      _weightController,
      _ageController,
    ]) {
      controller.removeListener(_onFieldChanged);
      controller.dispose();
    }
    super.dispose();
  }

  void _onFieldChanged() {
    if (!_showSaveButton) {
      setState(() => _showSaveButton = true);
    }
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      _nameController.text = prefs.getString('user_name') ?? '';
      _contactController.text = prefs.getString('user_contact') ?? '';
      _heightController.text = prefs.getString('user_height') ?? '';
      _weightController.text = prefs.getString('user_weight') ?? '';
      _ageController.text = prefs.getString('user_age') ?? '';
      _isLoading = false;
      _showSaveButton = false;
    });
  }

  Future<void> _saveProfile() async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      if (userId == null) return;

      final updatedAccount = await client.user.updateAccount(
        userId,
        _nameController.text.trim(),
        _contactController.text.trim(),
      );

      if (updatedAccount == null) {
        if (!mounted) return;
        messenger.showSnackBar(
          const SnackBar(content: Text('Проверьте имя и контакт')),
        );
        return;
      }

      var updatedUser = await client.user.updateProfile(
        userId,
        _heightController.text.trim(),
        _weightController.text.trim(),
        _ageController.text.trim(),
      );

      if (updatedUser == null) return;

      final avatarState = _avatarKey.currentState;
      if (avatarState != null && avatarState.hasImage) {
        updatedUser =
            await saveProfileImageFrameForUser(userId, avatarState.frame) ??
            updatedUser;
      }

      await saveUserSession(updatedUser);

      try {
        final bodyWeights = await waitForServer(
          client.user.listBodyWeights(userId),
        );
        await OfflineCache.saveBodyWeights(userId, bodyWeights);
      } catch (_) {}

      if (!mounted) return;
      _avatarKey.currentState?.finishEditing();
      setState(() => _showSaveButton = false);

      messenger.showSnackBar(
        const SnackBar(content: Text('Профиль сохранен')),
      );
    } catch (error) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Ошибка обновления профиля: $error')),
      );
    }
  }

  Future<String?> _uploadProfileImage(
    String fileName,
    String base64Data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (!mounted || userId == null) return null;

    return uploadProfileImageForUser(
      context: context,
      userId: userId,
      fileName: fileName,
      base64Data: base64Data,
    );
  }

  Future<void> _removeProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (!mounted || userId == null) return;

    await removeProfileImageForUser(context: context, userId: userId);
  }

  void _setAvatarDragging(bool isDragging) {
    if (_isAvatarDragging != isDragging) {
      setState(() => _isAvatarDragging = isDragging);
    }
  }

  Future<void> _logout() async {
    final navigator = Navigator.of(context);
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      physics: _isAvatarDragging
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _avatarBlock(),
          const SizedBox(height: 24),
          const Text(
            'Аккаунт',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          _buildInputField(
            'Имя',
            _nameController,
            icon: Icons.person_outline,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 12),
          _buildInputField(
            'Телефон или почта',
            _contactController,
            icon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.text,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Colors.black12, thickness: 1),
          ),
          const Text(
            'Антропометрия',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildInputField('Рост', _heightController)),
              const SizedBox(width: 12),
              Expanded(child: _buildInputField('Вес', _weightController)),
            ],
          ),
          const SizedBox(height: 12),
          _buildInputField('Возраст', _ageController, width: double.infinity),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _showSaveButton ? _saveProfile : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D76E4),
                disabledBackgroundColor: const Color(0xFFE6E8EF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Сохранить профиль',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: OutlinedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text(
                'Выйти из аккаунта',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _avatarBlock() {
    return Center(
      child: EditableProfileAvatar(
        key: _avatarKey,
        onChanged: _onFieldChanged,
        onDraggingChanged: _setAvatarDragging,
        onImagePicked: _uploadProfileImage,
        onImageRemoved: _removeProfileImage,
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    IconData? icon,
    TextInputType keyboardType = TextInputType.number,
    double? width,
  }) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon == null ? null : Icon(icon, color: Colors.grey),
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          filled: true,
          fillColor: const Color(0xFFF8F9FA),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF3D76E4), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}
