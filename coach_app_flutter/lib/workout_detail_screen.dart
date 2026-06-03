import 'dart:convert';

import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';
import 'app_theme.dart';
import 'app_ui.dart';
import 'core/app_colors.dart';
import 'exercise_library_screen.dart';
import 'main.dart';
import 'offline_cache.dart';
import 'server_request.dart';
import 'set_sheet.dart';
import 'video_launcher.dart';
import 'workout_detail_models.dart';
import 'workout_exercise_card.dart';
import 'workout_header.dart';
import 'workout_sheet.dart';
import 'workout_video_sheet.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final Workout workout;
  final int? initialVideoSetId;
  final int? initialVideoId;

  const WorkoutDetailScreen({
    super.key,
    required this.workout,
    this.initialVideoSetId,
    this.initialVideoId,
  });

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  late Workout _workout;
  List<WorkoutExercise> _workoutExercises = [];
  List<Exercise> _library = [];
  final Map<int, List<WorkoutSet>> _setsByExerciseId = {};
  final Map<int, List<WorkoutVideo>> _videosBySetId = {};
  final Map<int, List<VideoComment>> _commentsByVideoId = {};
  final Map<int, User> _commentAuthorsByCoachId = {};
  String _webServerUrl = '';
  int? _currentUserId;
  bool _isAthlete = true;
  bool _isUploadingVideo = false;
  bool _openedInitialVideo = false;
  String? _loadError;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _workout = widget.workout;
    _loadWorkout();
  }

  Future<void> _loadWorkout() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final isAthlete = prefs.getBool('is_athlete') ?? true;
    final webServerUrl = await resolveWebServerUrl();

    List<Exercise> library = [];
    List<WorkoutExercise> workoutExercises = [];
    final setsByExerciseId = <int, List<WorkoutSet>>{};
    final videosBySetId = <int, List<WorkoutVideo>>{};
    final commentsByVideoId = <int, List<VideoComment>>{};
    final commentAuthorsByCoachId = <int, User>{};
    String? loadError;

    if (userId != null && !isAthlete) {
      commentAuthorsByCoachId[userId] = User(
        id: userId,
        name: prefs.getString('user_name') ?? 'Тренер',
        contact: prefs.getString('user_contact') ?? '',
        password: '',
        isAthlete: false,
        imagePath: prefs.getString('user_image'),
        imageScale: prefs.getDouble('user_image_scale'),
        imageOffsetX: prefs.getDouble('user_image_offset_x'),
        imageOffsetY: prefs.getDouble('user_image_offset_y'),
      );
    }

    library = await OfflineCache.readExercises();
    workoutExercises = await OfflineCache.readWorkoutExercises(_workout.id!);
    for (final workoutExercise in workoutExercises) {
      setsByExerciseId[workoutExercise.id!] = await OfflineCache.readSets(
        workoutExercise.id!,
      );
    }

    if (mounted) {
      setState(() {
        _currentUserId = userId;
        _isAthlete = isAthlete;
        _webServerUrl = webServerUrl;
        _library = library;
        _workoutExercises = workoutExercises;
        _setsByExerciseId
          ..clear()
          ..addAll(setsByExerciseId);
        _isLoading = false;
      });
    }

    try {
      library = await waitForServer(client.training.listExercises());
      await OfflineCache.saveExercises(library);
      workoutExercises = await waitForServer(
        client.training.listWorkoutExercises(_workout.id!),
      );
      await OfflineCache.saveWorkoutExercises(_workout.id!, workoutExercises);
      setsByExerciseId.clear();
      videosBySetId.clear();
      commentsByVideoId.clear();

      for (final workoutExercise in workoutExercises) {
        final sets = await waitForServer(
          client.training.listSets(workoutExercise.id!),
        );
        setsByExerciseId[workoutExercise.id!] = sets;
        await OfflineCache.saveSets(workoutExercise.id!, sets);

        for (final set in sets) {
          final setId = set.id;
          if (setId == null) continue;

          final videos = await waitForServer(
            client.training.listSetVideos(setId),
          );
          videosBySetId[setId] = videos;

          for (final video in videos) {
            final videoId = video.id;
            if (videoId == null) continue;

            commentsByVideoId[videoId] = await waitForServer(
              client.training.listVideoComments(videoId),
            );
          }
        }
      }

      await _loadCommentAuthors(
        commentsByVideoId.values.expand((comments) => comments),
        commentAuthorsByCoachId,
      );

      final progress = await waitForServer(
        client.training.getProgress(_workout.userId, null),
      );
      await OfflineCache.saveProgress(_workout.userId, progress);
    } catch (_) {
      loadError =
          'Сервер не отвечает. Показаны сохраненные данные, видео обновится при подключении.';
    }

    if (!mounted) return;
    setState(() {
      _library = library;
      _workoutExercises = workoutExercises;
      _setsByExerciseId
        ..clear()
        ..addAll(setsByExerciseId);
      _videosBySetId
        ..clear()
        ..addAll(videosBySetId);
      _commentsByVideoId
        ..clear()
        ..addAll(commentsByVideoId);
      _commentAuthorsByCoachId
        ..clear()
        ..addAll(commentAuthorsByCoachId);
      _loadError = loadError;
      _isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openInitialVideoIfNeeded();
    });
  }

  Future<void> _loadCommentAuthors(
    Iterable<VideoComment> comments,
    Map<int, User> target,
  ) async {
    final coachIds = comments.map((comment) => comment.coachId).toSet();
    for (final coachId in coachIds) {
      if (target.containsKey(coachId)) continue;

      try {
        final coach = await waitForServer(client.user.getUser(coachId));
        if (coach != null) target[coachId] = coach;
      } catch (_) {}
    }
  }

  Future<void> _addExercise() async {
    final exercise = await Navigator.of(context).push<Exercise>(
      MaterialPageRoute(
        builder: (_) => const ExerciseLibraryScreen(selectionMode: true),
      ),
    );

    if (exercise == null) return;
    try {
      await waitForServer(
        client.training.addExerciseToWorkout(_workout.id!, exercise.id!),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось добавить упражнение')),
      );
      return;
    }
    await _loadWorkout();
  }

  Future<void> _addSet(WorkoutExercise workoutExercise) async {
    if (!_isAthlete) return;

    final sets = _setsByExerciseId[workoutExercise.id!] ?? const [];
    final lastSet = sets.isEmpty ? null : sets.last;
    final result = await showAppBottomSheet<SetInput>(
      context,
      SetSheet(
        exerciseName: workoutExercise.exerciseName,
        setIndex: sets.length + 1,
        initialWeight: lastSet?.weight ?? 0,
        initialReps: lastSet?.reps ?? 10,
      ),
    );

    if (result == null) return;
    try {
      await waitForServer(
        client.training.addSet(
          workoutExercise.id!,
          result.weight,
          result.reps,
          result.notes,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось сохранить подход')),
      );
      return;
    }
    await _loadWorkout();
  }

  Future<void> _attachVideo(WorkoutSet set) async {
    if (!_isAthlete || _isUploadingVideo || set.id == null) return;

    final messenger = ScaffoldMessenger.of(context);
    final pickedVideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedVideo == null) return;

    setState(() => _isUploadingVideo = true);
    try {
      final bytes = await pickedVideo.readAsBytes();
      const maxVideoBytes = 55 * 1024 * 1024;
      if (bytes.length > maxVideoBytes) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Для демо выбери видео меньше 55 МБ'),
          ),
        );
        return;
      }

      final uploadedVideo = await waitForServer(
        client.training.uploadSetVideo(
          set.id!,
          pickedVideo.name,
          base64Encode(bytes),
        ),
        timeout: serverUploadTimeout,
      );

      if (uploadedVideo == null) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Не удалось прикрепить видео')),
        );
        return;
      }

      messenger.showSnackBar(
        const SnackBar(content: Text('Видео прикреплено к подходу')),
      );
      await _loadWorkout();
    } catch (error) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Ошибка загрузки видео: $error')),
      );
    } finally {
      if (mounted) setState(() => _isUploadingVideo = false);
    }
  }

  void _openInitialVideoIfNeeded() {
    if (_openedInitialVideo) return;

    final setId = widget.initialVideoSetId;
    if (setId == null) return;

    WorkoutSet? targetSet;
    for (final sets in _setsByExerciseId.values) {
      for (final set in sets) {
        if (set.id == setId) {
          targetSet = set;
          break;
        }
      }
      if (targetSet != null) break;
    }

    final videos = _videosBySetId[setId] ?? const <WorkoutVideo>[];
    if (targetSet == null || videos.isEmpty) return;

    _openedInitialVideo = true;
    _openVideos(targetSet, focusedVideoId: widget.initialVideoId);
  }

  Future<void> _openVideos(WorkoutSet set, {int? focusedVideoId}) async {
    final videos = _videosBySetId[set.id] ?? const <WorkoutVideo>[];

    await showAppBottomSheet<void>(
      context,
      WorkoutVideoSheet(
        videos: videos,
        commentsByVideoId: _commentsByVideoId,
        commentAuthorsByCoachId: _commentAuthorsByCoachId,
        focusedVideoId: focusedVideoId,
        canComment: !_isAthlete,
        onOpenVideo: _openVideo,
        onAddComment: _addVideoComment,
      ),
    );
  }

  Future<void> _openVideo(WorkoutVideo video) async {
    final url = _videoUrl(video);
    try {
      final opened = await VideoLauncher.open(url);
      if (opened) return;

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ссылка на видео: $url')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось открыть видео: $error')),
      );
    }
  }

  Future<List<VideoComment>> _addVideoComment(
    WorkoutVideo video,
    String text,
  ) async {
    final coachId = _currentUserId;
    final videoId = video.id;
    if (coachId == null || videoId == null || _isAthlete) {
      return _commentsByVideoId[videoId] ?? const [];
    }

    await waitForServer(
      client.training.addVideoComment(videoId, coachId, text),
    );
    final comments = await waitForServer(
      client.training.listVideoComments(videoId),
    );
    final commentAuthorsByCoachId = Map<int, User>.from(
      _commentAuthorsByCoachId,
    );
    await _loadCommentAuthors(comments, commentAuthorsByCoachId);

    if (mounted) {
      setState(() {
        _commentsByVideoId[videoId] = comments;
        _commentAuthorsByCoachId
          ..clear()
          ..addAll(commentAuthorsByCoachId);
      });
    }
    return comments;
  }

  Future<void> _editWorkout() async {
    final result = await showAppBottomSheet<WorkoutInput>(
      context,
      WorkoutSheet(workout: _workout),
    );

    if (result == null) return;
    Workout? updatedWorkout;
    try {
      if (_isAthlete) {
        updatedWorkout = await waitForServer(
          client.training.updateWorkout(
            _workout.id!,
            result.title,
            result.scheduledAt,
            result.durationMinutes,
            result.notes,
            _workout.isCompleted,
          ),
        );
      } else {
        final coachId = _currentUserId;
        if (coachId == null) return;
        updatedWorkout = await waitForServer(
          client.coach.updateAthleteWorkout(
            coachId,
            _workout.id!,
            result.title,
            result.scheduledAt,
            result.durationMinutes,
            result.notes,
            _workout.isCompleted,
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось сохранить тренировку')),
      );
      return;
    }

    final workout = updatedWorkout;
    if (workout == null) return;
    if (!mounted) return;
    setState(() => _workout = workout);
  }

  Future<void> _deleteWorkout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить тренировку?'),
        content: const Text(
          'Тренировка, упражнения, подходы, видео и комментарии будут удалены.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Удалить',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      final workoutId = _workout.id;
      if (workoutId == null) return;

      final deleted = _isAthlete
          ? await waitForServer(client.training.deleteWorkout(workoutId))
          : await _deleteWorkoutAsCoach(workoutId);

      if (!mounted) return;
      if (!deleted) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Не удалось удалить тренировку')),
        );
        return;
      }

      messenger.showSnackBar(
        const SnackBar(content: Text('Тренировка удалена')),
      );
      navigator.pop(true);
    } catch (error) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Ошибка удаления: $error')),
      );
    }
  }

  Future<bool> _deleteWorkoutAsCoach(int workoutId) async {
    final coachId = _currentUserId;
    if (coachId == null) return false;

    return waitForServer(
      client.coach.deleteAthleteWorkout(coachId, workoutId),
    );
  }

  Future<void> _toggleComplete() async {
    if (!_isAthlete) return;

    Workout? updatedWorkout;
    try {
      updatedWorkout = await waitForServer(
        client.training.updateWorkout(
          _workout.id!,
          _workout.title,
          _workout.scheduledAt,
          _workout.durationMinutes,
          _workout.notes ?? '',
          !_workout.isCompleted,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось обновить тренировку')),
      );
      return;
    }

    final workout = updatedWorkout;
    if (workout == null) return;
    if (!mounted) return;
    setState(() => _workout = workout);
  }

  String _videoUrl(WorkoutVideo video) {
    final base = _webServerUrl.endsWith('/')
        ? _webServerUrl
        : '$_webServerUrl/';
    return '$base${video.filePath}';
  }

  Exercise? _libraryExerciseFor(WorkoutExercise workoutExercise) {
    for (final exercise in _library) {
      if (exercise.id == workoutExercise.exerciseId) return exercise;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Тренировка',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Удалить',
            onPressed: _deleteWorkout,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.redAccent,
            ),
          ),
          IconButton(
            tooltip: 'Настроить',
            onPressed: _editWorkout,
            icon: const Icon(Icons.edit_calendar_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadWorkout,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            WorkoutHeader(workout: _workout, onTap: _editWorkout),
            const SizedBox(height: 16),
            AddExerciseCard(onTap: _addExercise),
            if (_isUploadingVideo) ...[
              const SizedBox(height: 12),
              const LinearProgressIndicator(minHeight: 3),
            ],
            const SizedBox(height: 16),
            _workoutContent(),
            if (_isAthlete) ...[
              const SizedBox(height: 6),
              SizedBox(
                height: 58,
                child: ElevatedButton(
                  onPressed: _toggleComplete,
                  style: primaryButtonStyle(
                    background: _workout.isCompleted
                        ? (isAppDark(context)
                              ? const Color(0xFF2A2D36)
                              : Colors.black87)
                        : AppColors.primaryBlue,
                    radius: 18,
                  ),
                  child: Text(
                    _workout.isCompleted
                        ? 'Вернуть в план'
                        : 'Завершить тренировку',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _workoutContent() {
    final children = <Widget>[
      if (_loadError != null) ...[
        ServerProblemCard(message: _loadError!, onRetry: _loadWorkout),
        const SizedBox(height: 16),
      ],
    ];

    if (_isLoading) {
      children.add(
        const Padding(
          padding: EdgeInsets.only(top: 60),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    } else if (_workoutExercises.isEmpty) {
      children.add(const EmptyWorkoutCard());
    } else {
      children.addAll([
        for (final workoutExercise in _workoutExercises)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: WorkoutExerciseCard(
              workoutExercise: workoutExercise,
              sets: _setsByExerciseId[workoutExercise.id!] ?? const [],
              videosBySetId: _videosBySetId,
              libraryExercise: _libraryExerciseFor(workoutExercise),
              canAddSet: _isAthlete,
              onAddSet: () => _addSet(workoutExercise),
              onAttachVideo: _attachVideo,
              onOpenVideos: _openVideos,
            ),
          ),
      ]);
    }

    return Column(children: children);
  }
}
