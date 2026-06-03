import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'profile_avatar_editor.dart';
import 'server_request.dart';
import 'user_cache.dart';

Future<String?> uploadProfileImageForUser({
  required BuildContext context,
  required int userId,
  required String fileName,
  required String base64Data,
}) async {
  try {
    final user = await waitForServer(
      client.user.uploadProfileImage(userId, fileName, base64Data),
    );
    if (user == null) return null;

    await saveUserSession(user);
    return user.imagePath;
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось загрузить фото профиля')),
      );
    }
    return null;
  }
}

Future<void> removeProfileImageForUser({
  required BuildContext context,
  required int userId,
}) async {
  try {
    final user = await waitForServer(client.user.removeProfileImage(userId));
    if (user != null) await saveUserSession(user);
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось удалить фото профиля')),
      );
    }
  }
}

Future<User?> saveProfileImageFrameForUser(
  int userId,
  AvatarFrame frame,
) {
  return waitForServer(
    client.user.updateProfileImageFrame(
      userId,
      frame.scale,
      frame.offsetX,
      frame.offsetY,
    ),
  );
}
