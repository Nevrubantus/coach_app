import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';
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

  final prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(CoachApp(isLoggedIn: loggedIn));
}

class CoachApp extends StatelessWidget {
  final bool isLoggedIn;

  const CoachApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coach App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3D76E4)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: isLoggedIn ? const RoleGate() : const LoginScreen(),
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
        backgroundColor: Colors.white,
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
