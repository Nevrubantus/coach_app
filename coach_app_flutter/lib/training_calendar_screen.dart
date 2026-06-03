import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_ui.dart';
import 'core/app_colors.dart';
import 'main.dart';
import 'new_workout_sheet.dart';
import 'offline_cache.dart';
import 'server_request.dart';
import 'training_calendar_widgets.dart';
import 'training_formatters.dart';
import 'workout_detail_screen.dart';

class TrainingCalendarScreen extends StatefulWidget {
  const TrainingCalendarScreen({super.key});

  @override
  State<TrainingCalendarScreen> createState() => _TrainingCalendarScreenState();
}

class _TrainingCalendarScreenState extends State<TrainingCalendarScreen> {
  int? _userId;
  DateTime _focusedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime _selectedDate = DateTime.now();
  List<Workout> _workouts = [];
  String? _loadError;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCalendar();
  }

  Future<void> _loadCalendar() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId == null) {
      if (!mounted) return;
      setState(() {
        _userId = null;
        _isLoading = false;
      });
      return;
    }

    List<Workout> workouts = [];
    String? loadError;
    final cachedWorkouts = await OfflineCache.readWorkoutsForMonth(
      userId,
      _focusedMonth,
    );

    if (!mounted) return;
    setState(() {
      _userId = userId;
      _workouts = cachedWorkouts;
      _isLoading = false;
    });

    try {
      workouts = await waitForServer(
        client.training.getWorkoutsForMonth(userId, _focusedMonth),
      );
      await OfflineCache.saveWorkoutsForMonth(
        userId,
        _focusedMonth,
        workouts,
      );
    } catch (_) {
      workouts = cachedWorkouts;
      loadError = 'Сервер не отвечает. Проверь, что Serverpod запущен.';
    }

    if (!mounted) return;
    setState(() {
      _userId = userId;
      _workouts = workouts;
      _loadError = loadError;
      _isLoading = false;
    });
  }

  Future<void> _createWorkout() async {
    final userId = _userId;
    if (userId == null) return;

    final result = await showAppBottomSheet<NewWorkoutInput>(
      context,
      NewWorkoutSheet(initialDate: _selectedDate),
    );
    if (result == null) return;

    Workout workout;
    try {
      workout = await waitForServer(
        client.training.createWorkout(userId, result.title, result.scheduledAt),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось создать тренировку')),
      );
      return;
    }

    await _loadCalendar();
    if (!mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WorkoutDetailScreen(workout: workout)),
    );
    await _loadCalendar();
  }

  Future<void> _openWorkout(Workout workout) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WorkoutDetailScreen(workout: workout)),
    );
    await _loadCalendar();
  }

  void _changeMonth(int delta) {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + delta);
      _selectedDate = DateTime(_focusedMonth.year, _focusedMonth.month);
    });
    _loadCalendar();
  }

  List<Workout> get _selectedWorkouts {
    return _workouts
        .where((workout) => isSameDay(workout.scheduledAt, _selectedDate))
        .toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadCalendar,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        children: [
          const Text(
            'Календарь тренировок',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          NewWorkoutCard(onTap: _createWorkout),
          if (_loadError != null) ...[
            const SizedBox(height: 12),
            ServerProblemCard(message: _loadError!, onRetry: _loadCalendar),
          ],
          const SizedBox(height: 16),
          _MonthSwitcher(
            title: formatCalendarTitle(_focusedMonth),
            onPrevious: () => _changeMonth(-1),
            onNext: () => _changeMonth(1),
          ),
          const SizedBox(height: 10),
          CalendarCard(
            month: _focusedMonth,
            selectedDate: _selectedDate,
            workouts: _workouts,
            onDateSelected: (date) => setState(() => _selectedDate = date),
          ),
          const SizedBox(height: 22),
          Text(
            isSameDay(_selectedDate, DateTime.now())
                ? 'Сегодня'
                : formatShortDate(_selectedDate),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          _ScheduleList(
            isLoading: _isLoading,
            workouts: _selectedWorkouts,
            onWorkoutTap: _openWorkout,
          ),
        ],
      ),
    );
  }
}

class _MonthSwitcher extends StatelessWidget {
  final String title;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _MonthSwitcher({
    required this.title,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Предыдущий месяц',
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textGrey,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        IconButton(
          tooltip: 'Следующий месяц',
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}

class _ScheduleList extends StatelessWidget {
  final bool isLoading;
  final List<Workout> workouts;
  final ValueChanged<Workout> onWorkoutTap;

  const _ScheduleList({
    required this.isLoading,
    required this.workouts,
    required this.onWorkoutTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.only(top: 48),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (workouts.isEmpty) {
      return const EmptyScheduleCard();
    }

    return Column(
      children: [
        for (final workout in workouts)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: WorkoutScheduleCard(
              workout: workout,
              onTap: () => onWorkoutTap(workout),
            ),
          ),
      ],
    );
  }
}
