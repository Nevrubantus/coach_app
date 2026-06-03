import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const appThemeModeKey = 'app_theme_mode';
final appThemeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

Future<void> loadAppThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  appThemeMode.value = prefs.getString(appThemeModeKey) == 'dark'
      ? ThemeMode.dark
      : ThemeMode.light;
}

Future<void> setAppDarkTheme(bool isDark) async {
  final nextMode = isDark ? ThemeMode.dark : ThemeMode.light;
  if (appThemeMode.value == nextMode) return;

  appThemeMode.value = nextMode;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(appThemeModeKey, isDark ? 'dark' : 'light');
}

bool isAppDark(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

Color appSurfaceColor(BuildContext context) {
  return isAppDark(context) ? const Color(0xFF181A20) : Colors.white;
}

Color appFieldColor(BuildContext context) {
  return isAppDark(context) ? const Color(0xFF20232B) : const Color(0xFFF8F9FA);
}

Color appBorderColor(BuildContext context) {
  return isAppDark(context) ? const Color(0xFF343844) : const Color(0xFFEDEDF2);
}

Color appMutedTextColor(BuildContext context) {
  return isAppDark(context) ? const Color(0xFFB0B3BD) : const Color(0xFF8E8E93);
}
