import 'package:coach_app_client/coach_app_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserSession(User user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_logged_in', true);
  await prefs.setInt('user_id', user.id!);
  await prefs.setString('user_name', user.name);
  await prefs.setString('user_contact', user.contact);
  await prefs.setBool('is_athlete', user.isAthlete);
  await _setNullableString(prefs, 'user_height', user.height);
  await _setNullableString(prefs, 'user_weight', user.weight);
  await _setNullableString(prefs, 'user_age', user.age);
  final imagePath = user.imagePath?.trim();
  if (imagePath != null && imagePath.isNotEmpty) {
    await prefs.setString('user_image', imagePath);
    await prefs.setDouble('user_image_scale', user.imageScale ?? 1);
    await prefs.setDouble('user_image_offset_x', user.imageOffsetX ?? 0);
    await prefs.setDouble('user_image_offset_y', user.imageOffsetY ?? 0);
  } else {
    await prefs.remove('user_image');
    await prefs.remove('user_image_scale');
    await prefs.remove('user_image_offset_x');
    await prefs.remove('user_image_offset_y');
  }
}

Future<void> _setNullableString(
  SharedPreferences prefs,
  String key,
  String? value,
) {
  final normalizedValue = value?.trim();
  if (normalizedValue == null || normalizedValue.isEmpty) {
    return prefs.remove(key);
  }

  return prefs.setString(key, normalizedValue);
}
