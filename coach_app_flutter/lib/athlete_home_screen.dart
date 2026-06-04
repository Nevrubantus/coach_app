import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'athlete_home_widgets.dart';
import 'app_ui.dart';
import 'core/app_colors.dart';
import 'main.dart';
import 'offline_cache.dart';
import 'profile_avatar_editor.dart';
import 'server_request.dart';
import 'workout_detail_screen.dart';

class AthleteHomeScreen extends StatefulWidget {
  final VoidCallback onOpenCalendar;
  final VoidCallback onOpenProgress;

  const AthleteHomeScreen({
    super.key,
    required this.onOpenCalendar,
    required this.onOpenProgress,
  });

  @override
  State<AthleteHomeScreen> createState() => _AthleteHomeScreenState();
}

class _AthleteHomeScreenState extends State<AthleteHomeScreen> {
  final _scrollController = ScrollController();
  final _workoutKey = GlobalKey();
  final _progressKey = GlobalKey();
  final _anthropometryKey = GlobalKey();

  String _name = 'атлет';
  String _height = '';
  String _weight = '';
  String _age = '';
  User? _coach;
  Workout? _upcomingWorkout;
  List<ProgressPoint> _progressPoints = [];
  int _monthWorkoutCount = 0;
  String? _loadError;
  bool _isLoading = true;
  bool _isOpeningCoachComment = false;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadDashboard() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final currentMonth = DateTime(DateTime.now().year, DateTime.now().month);

    var upcomingWorkout = userId == null
        ? null
        : await OfflineCache.readUpcomingWorkout(userId);
    var progressPoints = userId == null
        ? <ProgressPoint>[]
        : await OfflineCache.readProgress(userId);
    final cachedMonthWorkouts = userId == null
        ? <Workout>[]
        : await OfflineCache.readWorkoutsForMonth(userId, currentMonth);
    var monthWorkoutCount = cachedMonthWorkouts.length;
    var coach = _readCachedCoach(prefs);

    if (!mounted) return;
    setState(() {
      _name = prefs.getString('user_name')?.trim().split(' ').first ?? 'атлет';
      _height = prefs.getString('user_height') ?? '';
      _weight = prefs.getString('user_weight') ?? '';
      _age = prefs.getString('user_age') ?? '';
      _coach = coach;
      _upcomingWorkout = upcomingWorkout;
      _progressPoints = progressPoints;
      _monthWorkoutCount = monthWorkoutCount;
      _isLoading = false;
    });

    if (userId == null) return;

    String? loadError;
    try {
      final freshData = await waitForServer(
        Future.wait<dynamic>([
          client.training.getUpcomingWorkout(userId),
          client.training.getProgress(userId, null),
          client.training.getWorkoutsForMonth(userId, currentMonth),
          client.coach.getCoachForAthlete(userId),
        ]),
      );

      upcomingWorkout = freshData[0] as Workout?;
      progressPoints = freshData[1] as List<ProgressPoint>;
      final monthWorkouts = freshData[2] as List<Workout>;
      coach = freshData[3] as User?;
      monthWorkoutCount = monthWorkouts.length;

      await OfflineCache.saveUpcomingWorkout(userId, upcomingWorkout);
      await OfflineCache.saveProgress(userId, progressPoints);
      await OfflineCache.saveWorkoutsForMonth(
        userId,
        currentMonth,
        monthWorkouts,
      );
      await _saveCachedCoach(prefs, coach);
    } catch (_) {
      loadError = 'Сервер не отвечает. Показаны сохраненные данные.';
    }

    if (!mounted) return;
    setState(() {
      _upcomingWorkout = upcomingWorkout;
      _progressPoints = progressPoints;
      _monthWorkoutCount = monthWorkoutCount;
      _coach = coach;
      _loadError = loadError;
      _isLoading = false;
    });
  }

  User? _readCachedCoach(SharedPreferences prefs) {
    final name = prefs.getString('athlete_coach_name');
    if (name == null || name.trim().isEmpty) return null;

    return User(
      id: prefs.getInt('athlete_coach_id'),
      name: name,
      contact: prefs.getString('athlete_coach_contact') ?? '',
      password: '',
      isAthlete: false,
      imagePath: prefs.getString('athlete_coach_image'),
      imageScale: prefs.getDouble('athlete_coach_image_scale'),
      imageOffsetX: prefs.getDouble('athlete_coach_image_offset_x'),
      imageOffsetY: prefs.getDouble('athlete_coach_image_offset_y'),
    );
  }

  Future<void> _saveCachedCoach(SharedPreferences prefs, User? coach) async {
    if (coach == null) {
      await prefs.remove('athlete_coach_id');
      await prefs.remove('athlete_coach_name');
      await prefs.remove('athlete_coach_contact');
      await prefs.remove('athlete_coach_image');
      await prefs.remove('athlete_coach_image_scale');
      await prefs.remove('athlete_coach_image_offset_x');
      await prefs.remove('athlete_coach_image_offset_y');
      return;
    }

    final coachId = coach.id;
    if (coachId != null) await prefs.setInt('athlete_coach_id', coachId);
    await prefs.setString('athlete_coach_name', coach.name);
    await prefs.setString('athlete_coach_contact', coach.contact);

    final imagePath = coach.imagePath?.trim();
    if (imagePath == null || imagePath.isEmpty) {
      await prefs.remove('athlete_coach_image');
      await prefs.remove('athlete_coach_image_scale');
      await prefs.remove('athlete_coach_image_offset_x');
      await prefs.remove('athlete_coach_image_offset_y');
    } else {
      await prefs.setString('athlete_coach_image', imagePath);
      await prefs.setDouble('athlete_coach_image_scale', coach.imageScale ?? 1);
      await prefs.setDouble(
        'athlete_coach_image_offset_x',
        coach.imageOffsetX ?? 0,
      );
      await prefs.setDouble(
        'athlete_coach_image_offset_y',
        coach.imageOffsetY ?? 0,
      );
    }
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      alignment: 0.06,
    );
  }

  Future<void> _openUpcomingWorkout() async {
    final workout = _upcomingWorkout;
    if (workout == null) return;

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WorkoutDetailScreen(workout: workout)),
    );
    await _loadDashboard();
  }

  Future<void> _openLatestCoachComment() async {
    final coach = _coach;
    final coachId = coach?.id;
    if (_isOpeningCoachComment || coachId == null) return;

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId == null) return;

    setState(() => _isOpeningCoachComment = true);
    messenger.showSnackBar(
      const SnackBar(content: Text('Ищем последний комментарий тренера...')),
    );

    try {
      final target = await _findLatestCoachComment(userId, coachId);
      if (!mounted) return;
      messenger.hideCurrentSnackBar();

      if (target == null) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Комментариев тренера к видео пока нет.'),
          ),
        );
        return;
      }

      await navigator.push(
        MaterialPageRoute(
          builder: (_) => WorkoutDetailScreen(
            workout: target.workout,
            initialVideoSetId: target.video.workoutSetId,
            initialVideoId: target.video.id,
          ),
        ),
      );
      await _loadDashboard();
    } catch (_) {
      if (!mounted) return;
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Не удалось открыть комментарий. Проверьте сервер.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isOpeningCoachComment = false);
    }
  }

  Future<_CoachCommentTarget?> _findLatestCoachComment(
    int userId,
    int coachId,
  ) async {
    final workouts = await waitForServer(
      client.training.listWorkouts(userId),
      timeout: const Duration(seconds: 40),
    );

    _CoachCommentTarget? latest;
    for (final workout in workouts) {
      final workoutId = workout.id;
      if (workoutId == null) continue;

      final videos = await waitForServer(
        client.training.listWorkoutVideos(workoutId),
        timeout: const Duration(seconds: 25),
      );

      for (final video in videos) {
        final videoId = video.id;
        if (videoId == null) continue;

        final comments = await waitForServer(
          client.training.listVideoComments(videoId),
          timeout: const Duration(seconds: 25),
        );

        for (final comment in comments) {
          if (comment.coachId != coachId) continue;

          if (latest == null ||
              comment.createdAt.isAfter(latest.comment.createdAt)) {
            latest = _CoachCommentTarget(
              workout: workout,
              video: video,
              comment: comment,
            );
          }
        }
      }
    }

    return latest;
  }

  List<ProgressPoint> get _selectedExercisePoints {
    if (_progressPoints.isEmpty) return const [];

    final exerciseName = _progressPoints.last.exerciseName;
    return _progressPoints
        .where((point) => point.exerciseName == exerciseName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPoints = _selectedExercisePoints;

    return RefreshIndicator(
      onRefresh: _loadDashboard,
      child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        children: [
          Text(
            'Привет, $_name!',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Двигайся ровно, день за днем.',
            style: TextStyle(color: AppColors.textGrey, fontSize: 15),
          ),
          const SizedBox(height: 24),
          MotivationBanner(monthWorkoutCount: _monthWorkoutCount),
          if (_coach != null) ...[
            const SizedBox(height: 12),
            _CoachCard(
              coach: _coach!,
              isLoading: _isOpeningCoachComment,
              onTap: _openLatestCoachComment,
            ),
          ],
          if (_loadError != null) ...[
            const SizedBox(height: 12),
            ServerProblemCard(message: _loadError!, onRetry: _loadDashboard),
          ],
          const SizedBox(height: 18),
          SummaryGrid(
            upcomingWorkout: _upcomingWorkout,
            progressPoints: selectedPoints,
            monthWorkoutCount: _monthWorkoutCount,
            weight: _weight,
            onWorkoutTap: widget.onOpenCalendar,
            onProgressTap: widget.onOpenProgress,
            onAnthropometryTap: () => _scrollTo(_anthropometryKey),
          ),
          const SizedBox(height: 30),
          UpcomingWorkoutSection(
            key: _workoutKey,
            workout: _upcomingWorkout,
            isLoading: _isLoading,
            onTap: _openUpcomingWorkout,
            onCreateTap: widget.onOpenCalendar,
          ),
          const SizedBox(height: 28),
          ProgressSection(
            key: _progressKey,
            points: selectedPoints,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 28),
          AnthropometrySection(
            key: _anthropometryKey,
            height: _height,
            weight: _weight,
            age: _age,
          ),
        ],
      ),
    );
  }
}

class _CoachCommentTarget {
  final Workout workout;
  final WorkoutVideo video;
  final VideoComment comment;

  const _CoachCommentTarget({
    required this.workout,
    required this.video,
    required this.comment,
  });
}

class _CoachCard extends StatelessWidget {
  final User coach;
  final bool isLoading;
  final VoidCallback onTap;

  const _CoachCard({
    required this.coach,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: softCardDecoration(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: isLoading ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                AvatarPreview(
                  imagePath: coach.imagePath,
                  radius: 22,
                  scale: coach.imageScale ?? 1,
                  offsetX: coach.imageOffsetX ?? 0,
                  offsetY: coach.imageOffsetY ?? 0,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ваш тренер',
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        coach.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (coach.contact.trim().isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          coach.contact,
                          style: const TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.4),
                  )
                else
                  const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColors.primaryBlue,
                  ),
                const SizedBox(width: 4),
                if (!isLoading)
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textGrey,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
