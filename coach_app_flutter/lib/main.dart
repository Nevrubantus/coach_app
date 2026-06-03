import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';
import 'app_theme.dart';
import 'athlete_home_screen.dart';
import 'coach_dashboard_screen.dart';
import 'login_screen.dart';
import 'profile_view.dart';
import 'progress_screen.dart';
import 'server_request.dart';
import 'training_calendar_screen.dart';
import 'user_cache.dart';

late final Client client;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final serverUrl = await resolveServerUrl();
  debugPrint('Serverpod URL: $serverUrl');
  client = Client(serverUrl);

  await loadAppThemeMode();

  final prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(CoachApp(isLoggedIn: loggedIn));
}

class CoachApp extends StatelessWidget {
  final bool isLoggedIn;

  const CoachApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, themeMode, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coach App',
        theme: _appTheme(Brightness.light),
        darkTheme: _appTheme(Brightness.dark),
        themeMode: themeMode,
        home: isLoggedIn ? const RoleGate() : const LoginScreen(),
      ),
    );
  }

  ThemeData _appTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3D76E4),
      brightness: brightness,
    );
    final background = isDark ? const Color(0xFF0D0F14) : Colors.white;
    final surface = isDark ? const Color(0xFF181A20) : Colors.white;
    final field = isDark ? const Color(0xFF20232B) : const Color(0xFFF8F9FA);
    final border = isDark ? const Color(0xFF343844) : const Color(0xFFE5E5EA);

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: isDark ? Colors.white : const Color(0xFF1D1D26),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: const Color(0xFF3D76E4),
        unselectedItemColor: isDark ? const Color(0xFF878A94) : Colors.grey,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: field,
        labelStyle: TextStyle(
          color: isDark ? const Color(0xFFB0B3BD) : Colors.grey,
        ),
        hintStyle: TextStyle(
          color: isDark ? const Color(0xFF878A94) : Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF3D76E4), width: 1.5),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color(0xFF3D76E4),
      ),
    );
  }
}

class RoleGate extends StatefulWidget {
  const RoleGate({super.key});

  @override
  State<RoleGate> createState() => _RoleGateState();
}

class _RoleGateState extends State<RoleGate> {
  bool? _isAthlete;

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final cachedRole = prefs.getBool('is_athlete') ?? true;

    if (userId != null) {
      try {
        final user = await waitForServer(client.user.getUser(userId));
        if (user != null) {
          await saveUserSession(user);
          if (!mounted) return;
          setState(() => _isAthlete = user.isAthlete);
          return;
        }
      } catch (_) {}
    }

    if (!mounted) return;
    setState(() => _isAthlete = cachedRole);
  }

  @override
  Widget build(BuildContext context) {
    final isAthlete = _isAthlete;
    if (isAthlete == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return isAthlete
        ? const MainNavigationScreen()
        : const CoachDashboardScreen();
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  static const _titles = [
    'Главная',
    'Тренировки',
    'График',
    'Профиль',
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      AthleteHomeScreen(
        onOpenCalendar: () => setState(() => _selectedIndex = 1),
        onOpenProgress: () => setState(() => _selectedIndex = 2),
      ),
      const TrainingCalendarScreen(),
      const ProgressScreen(),
      const ProfileView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3D76E4),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Тренировки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'График',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}
