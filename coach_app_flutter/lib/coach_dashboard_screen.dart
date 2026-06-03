import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_ui.dart';
import 'core/app_colors.dart';
import 'main.dart';
import 'new_workout_sheet.dart';
import 'progress_chart.dart';
import 'progress_screen.dart';
import 'profile_avatar_editor.dart';
import 'profile_view.dart';
import 'server_request.dart';
import 'training_calendar_screen.dart';
import 'training_formatters.dart';
import 'workout_detail_screen.dart';

part 'coach_dashboard_widgets.dart';

class CoachDashboardScreen extends StatefulWidget {
  const CoachDashboardScreen({super.key});

  @override
  State<CoachDashboardScreen> createState() => _CoachDashboardScreenState();
}

class _CoachDashboardScreenState extends State<CoachDashboardScreen> {
  final _contactController = TextEditingController();

  int _selectedIndex = 0;
  int? _coachId;
  String _coachName = 'тренер';
  User? _selectedAthlete;
  List<User> _athletes = [];
  List<Workout> _workouts = [];
  List<ProgressPoint> _progress = [];
  bool _isLoadingAthletes = true;
  bool _isLoadingWorkouts = false;
  bool _isAttaching = false;
  String? _loadError;
  String? _workoutError;

  static const _titles = [
    'Главная',
    'Тренировки учеников',
    'Мои тренировки',
    'Мой график',
    'Профиль',
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    final coachId = prefs.getInt('user_id');
    final coachName = prefs.getString('user_name') ?? 'тренер';

    if (!mounted) return;
    setState(() {
      _coachId = coachId;
      _coachName = coachName;
    });

    await _loadAthletes();
  }

  Future<void> _loadAthletes() async {
    final coachId = _coachId;
    if (coachId == null) {
      if (!mounted) return;
      setState(() => _isLoadingAthletes = false);
      return;
    }

    setState(() {
      _isLoadingAthletes = true;
      _loadError = null;
    });

    try {
      final athletes = await waitForServer(client.coach.listAthletes(coachId));
      if (!mounted) return;
      setState(() {
        _athletes = athletes;
        _isLoadingAthletes = false;
        if (_selectedAthlete != null) {
          _selectedAthlete = _matchSelectedAthlete(athletes);
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loadError = 'Сервер не отвечает. Список спортсменов недоступен.';
        _isLoadingAthletes = false;
      });
    }
  }

  User? _matchSelectedAthlete(List<User> athletes) {
    final selectedId = _selectedAthlete?.id;
    if (selectedId == null) return _selectedAthlete;
    for (final athlete in athletes) {
      if (athlete.id == selectedId) return athlete;
    }
    return _selectedAthlete;
  }

  Future<void> _attachAthlete() async {
    final coachId = _coachId;
    final contact = _contactController.text.trim();
    if (coachId == null || contact.isEmpty || _isAttaching) return;

    final messenger = ScaffoldMessenger.of(context);
    setState(() => _isAttaching = true);

    try {
      final athlete = await waitForServer(
        client.coach.attachAthleteByContact(coachId, contact),
      );
      if (athlete == null) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Спортсмен с таким телефоном не найден'),
          ),
        );
        return;
      }

      _contactController.clear();
      setState(() => _selectedAthlete = athlete);
      messenger.showSnackBar(
        SnackBar(content: Text('${athlete.name} закреплен за вами')),
      );
      await _loadAthletes();
      await _selectAthlete(athlete);
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Не удалось закрепить спортсмена')),
      );
    } finally {
      if (mounted) setState(() => _isAttaching = false);
    }
  }

  Future<void> _selectAthlete(User athlete) async {
    setState(() {
      _selectedAthlete = athlete;
      _selectedIndex = 1;
    });
    await _loadSelectedAthleteWorkouts();
  }

  Future<void> _loadSelectedAthleteWorkouts() async {
    final coachId = _coachId;
    final athleteId = _selectedAthlete?.id;
    if (coachId == null || athleteId == null) return;

    setState(() {
      _isLoadingWorkouts = true;
      _workoutError = null;
    });

    try {
      final workouts = await waitForServer(
        client.coach.listAthleteWorkouts(coachId, athleteId),
      );
      final progress = await waitForServer(
        client.training.getProgress(athleteId, null),
      );

      if (!mounted) return;
      setState(() {
        _workouts = workouts;
        _progress = progress;
        _isLoadingWorkouts = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _workoutError = 'Не удалось загрузить тренировки спортсмена.';
        _isLoadingWorkouts = false;
      });
    }
  }

  Future<void> _createWorkout() async {
    final coachId = _coachId;
    final athleteId = _selectedAthlete?.id;
    if (coachId == null || athleteId == null) return;

    final input = await showAppBottomSheet<NewWorkoutInput>(
      context,
      NewWorkoutSheet(initialDate: DateTime.now()),
    );
    if (input == null) return;

    Workout? workout;
    try {
      workout = await waitForServer(
        client.coach.createWorkoutForAthlete(
          coachId,
          athleteId,
          input.title,
          input.scheduledAt,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось назначить тренировку')),
      );
      return;
    }

    await _loadSelectedAthleteWorkouts();
    if (!mounted || workout == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WorkoutDetailScreen(workout: workout!)),
    );
    await _loadSelectedAthleteWorkouts();
  }

  Future<void> _openWorkout(Workout workout) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WorkoutDetailScreen(workout: workout)),
    );
    await _loadSelectedAthleteWorkouts();
  }

  List<Workout> get _upcomingWorkouts {
    final now = DateTime.now().toUtc();
    return _workouts
        .where(
          (workout) => !workout.isCompleted && workout.scheduledAt.isAfter(now),
        )
        .toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
  }

  List<Workout> get _pastWorkouts {
    final now = DateTime.now().toUtc();
    return _workouts
        .where(
          (workout) => workout.isCompleted || !workout.scheduledAt.isAfter(now),
        )
        .toList()
      ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
  }

  List<ProgressPoint> get _latestExerciseProgress {
    if (_progress.isEmpty) return const [];
    final exerciseName = _progress.last.exerciseName;
    return _progress
        .where((point) => point.exerciseName == exerciseName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _CoachHomePage(
        coachName: _coachName,
        contactController: _contactController,
        athletes: _athletes,
        isLoading: _isLoadingAthletes,
        isAttaching: _isAttaching,
        loadError: _loadError,
        onRefresh: _loadAthletes,
        onAttach: _attachAthlete,
        onAthleteTap: _selectAthlete,
      ),
      _CoachWorkoutsPage(
        athlete: _selectedAthlete,
        workouts: _workouts,
        progress: _latestExerciseProgress,
        upcomingWorkouts: _upcomingWorkouts,
        pastWorkouts: _pastWorkouts,
        isLoading: _isLoadingWorkouts,
        error: _workoutError,
        onRefresh: _loadSelectedAthleteWorkouts,
        onCreateWorkout: _createWorkout,
        onWorkoutTap: _openWorkout,
        onBackToAthletes: () => setState(() => _selectedIndex = 0),
      ),
      const TrainingCalendarScreen(),
      const ProgressScreen(),
      const ProfileView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) async {
          setState(() => _selectedIndex = index);
          if (index == 1 && _selectedAthlete != null) {
            await _loadSelectedAthleteWorkouts();
          } else if (index == 0) {
            await _loadInitialData();
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Ученики',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Мои',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_rounded),
            label: 'График',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}
