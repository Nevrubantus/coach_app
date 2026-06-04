import 'dart:convert';
import 'dart:io';

import '../generated/protocol.dart';
import 'workout_delete_helper.dart';
import 'package:serverpod/serverpod.dart';

class TrainingEndpoint extends Endpoint {
  Future<List<Exercise>> listExercises(Session session) async {
    await _ensureExerciseLibrary(session);

    final exercises = await Exercise.db.find(
      session,
      orderBy: (t) => t.name,
    );

    final visibleExercises = exercises.where((exercise) {
      final mediaUrl = exercise.mediaUrl;
      return mediaUrl == null || !mediaUrl.startsWith('technique://');
    }).toList();

    visibleExercises.sort((a, b) => a.name.compareTo(b.name));
    return visibleExercises;
  }

  Future<List<Workout>> listWorkouts(Session session, int userId) async {
    final workouts = await Workout.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.scheduledAt,
    );

    workouts.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    return workouts;
  }

  Future<List<Workout>> getWorkoutsForMonth(
    Session session,
    int userId,
    DateTime month,
  ) async {
    final workouts = await listWorkouts(session, userId);

    return workouts
        .where(
          (workout) =>
              workout.scheduledAt.year == month.year &&
              workout.scheduledAt.month == month.month,
        )
        .toList();
  }

  Future<Workout?> getUpcomingWorkout(Session session, int userId) async {
    final now = DateTime.now().toUtc();
    final workouts = await listWorkouts(session, userId);
    final upcoming =
        workouts
            .where(
              (workout) =>
                  !workout.isCompleted && workout.scheduledAt.isAfter(now),
            )
            .toList()
          ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

    return upcoming.isEmpty ? null : upcoming.first;
  }

  Future<Workout> createWorkout(
    Session session,
    int userId,
    String title,
    DateTime scheduledAt,
  ) async {
    final normalizedTitle = title.trim().isEmpty
        ? 'Новая тренировка'
        : title.trim();

    return Workout.db.insertRow(
      session,
      Workout(
        userId: userId,
        title: normalizedTitle,
        scheduledAt: scheduledAt.toUtc(),
        isCompleted: false,
      ),
    );
  }

  Future<Workout?> updateWorkout(
    Session session,
    int workoutId,
    String title,
    DateTime scheduledAt,
    int? durationMinutes,
    String notes,
    bool isCompleted,
  ) async {
    final workout = await Workout.db.findById(session, workoutId);
    if (workout == null) return null;

    return Workout.db.updateRow(
      session,
      workout.copyWith(
        title: title.trim().isEmpty ? workout.title : title.trim(),
        scheduledAt: scheduledAt.toUtc(),
        durationMinutes: durationMinutes,
        notes: notes.trim().isEmpty ? null : notes.trim(),
        isCompleted: isCompleted,
      ),
    );
  }

  Future<bool> deleteWorkout(Session session, int workoutId) {
    return deleteWorkoutCascade(session, workoutId);
  }

  Future<WorkoutExercise?> addExerciseToWorkout(
    Session session,
    int workoutId,
    int exerciseId,
  ) async {
    final workout = await Workout.db.findById(session, workoutId);
    final exercise = await Exercise.db.findById(session, exerciseId);
    if (workout == null || exercise == null) return null;

    final existing = await WorkoutExercise.db.find(
      session,
      where: (t) => t.workoutId.equals(workoutId),
    );

    return WorkoutExercise.db.insertRow(
      session,
      WorkoutExercise(
        workoutId: workoutId,
        exerciseId: exerciseId,
        exerciseName: exercise.name,
        orderIndex: existing.length + 1,
      ),
    );
  }

  Future<List<WorkoutExercise>> listWorkoutExercises(
    Session session,
    int workoutId,
  ) async {
    final exercises = await WorkoutExercise.db.find(
      session,
      where: (t) => t.workoutId.equals(workoutId),
      orderBy: (t) => t.orderIndex,
    );

    exercises.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    return exercises;
  }

  Future<WorkoutSet?> addSet(
    Session session,
    int workoutExerciseId,
    double weight,
    int reps,
    String notes,
  ) async {
    final workoutExercise = await WorkoutExercise.db.findById(
      session,
      workoutExerciseId,
    );
    if (workoutExercise == null) return null;

    final existingSets = await WorkoutSet.db.find(
      session,
      where: (t) => t.workoutExerciseId.equals(workoutExerciseId),
    );

    return WorkoutSet.db.insertRow(
      session,
      WorkoutSet(
        workoutExerciseId: workoutExerciseId,
        setIndex: existingSets.length + 1,
        weight: weight,
        reps: reps,
        notes: notes.trim().isEmpty ? null : notes.trim(),
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<List<WorkoutSet>> listSets(
    Session session,
    int workoutExerciseId,
  ) async {
    final sets = await WorkoutSet.db.find(
      session,
      where: (t) => t.workoutExerciseId.equals(workoutExerciseId),
      orderBy: (t) => t.setIndex,
    );

    sets.sort((a, b) => a.setIndex.compareTo(b.setIndex));
    return sets;
  }

  Future<WorkoutVideo?> uploadSetVideo(
    Session session,
    int workoutSetId,
    String fileName,
    String base64Data,
  ) async {
    final workoutSet = await WorkoutSet.db.findById(session, workoutSetId);
    if (workoutSet == null) return null;

    final workoutExercise = await WorkoutExercise.db.findById(
      session,
      workoutSet.workoutExerciseId,
    );
    if (workoutExercise == null) return null;

    final workout = await Workout.db.findById(
      session,
      workoutExercise.workoutId,
    );
    if (workout == null) return null;

    final bytes = base64Decode(base64Data);
    final storedFileName = _buildStoredVideoName(fileName);
    final uploadDirectory = Directory('web/static/uploads/videos');
    if (!uploadDirectory.existsSync()) {
      uploadDirectory.createSync(recursive: true);
    }

    final file = File('${uploadDirectory.path}/$storedFileName');
    await file.writeAsBytes(bytes, flush: true);

    return WorkoutVideo.db.insertRow(
      session,
      WorkoutVideo(
        workoutId: workout.id!,
        workoutExerciseId: workoutExercise.id!,
        workoutSetId: workoutSet.id!,
        athleteId: workout.userId,
        fileName: fileName.trim().isEmpty ? storedFileName : fileName.trim(),
        filePath: 'uploads/videos/$storedFileName',
        uploadedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<List<WorkoutVideo>> listSetVideos(
    Session session,
    int workoutSetId,
  ) async {
    final videos = await WorkoutVideo.db.find(
      session,
      where: (t) => t.workoutSetId.equals(workoutSetId),
      orderBy: (t) => t.uploadedAt,
    );

    videos.sort((a, b) => a.uploadedAt.compareTo(b.uploadedAt));
    return videos;
  }

  Future<List<WorkoutVideo>> listWorkoutVideos(
    Session session,
    int workoutId,
  ) async {
    final videos = await WorkoutVideo.db.find(
      session,
      where: (t) => t.workoutId.equals(workoutId),
      orderBy: (t) => t.uploadedAt,
    );

    videos.sort((a, b) => a.uploadedAt.compareTo(b.uploadedAt));
    return videos;
  }

  Future<VideoComment?> addVideoComment(
    Session session,
    int videoId,
    int coachId,
    String text,
  ) async {
    final normalizedText = text.trim();
    if (normalizedText.isEmpty) return null;

    final video = await WorkoutVideo.db.findById(session, videoId);
    final coach = await User.db.findById(session, coachId);
    if (video == null || coach == null || coach.isAthlete) return null;

    final link = await CoachAthlete.db.findFirstRow(
      session,
      where: (t) =>
          t.coachId.equals(coachId) & t.athleteId.equals(video.athleteId),
    );
    if (link == null) return null;

    return VideoComment.db.insertRow(
      session,
      VideoComment(
        videoId: videoId,
        coachId: coachId,
        coachName: coach.name,
        text: normalizedText,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<List<VideoComment>> listVideoComments(
    Session session,
    int videoId,
  ) async {
    final comments = await VideoComment.db.find(
      session,
      where: (t) => t.videoId.equals(videoId),
      orderBy: (t) => t.createdAt,
    );

    comments.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return comments;
  }

  Future<List<ProgressPoint>> getProgress(
    Session session,
    int userId,
    String? exerciseName,
  ) async {
    final normalizedExercise = exerciseName?.trim().toLowerCase();
    final workouts = await listWorkouts(session, userId);
    final points = <ProgressPoint>[];

    for (final workout in workouts) {
      final workoutExercises = await listWorkoutExercises(session, workout.id!);

      for (final workoutExercise in workoutExercises) {
        if (normalizedExercise != null &&
            normalizedExercise.isNotEmpty &&
            workoutExercise.exerciseName.toLowerCase() != normalizedExercise) {
          continue;
        }

        final sets = await listSets(session, workoutExercise.id!);
        if (sets.isEmpty) continue;

        final topWeight = sets
            .map((set) => set.weight)
            .reduce((value, element) => value > element ? value : element);

        points.add(
          ProgressPoint(
            date: workout.scheduledAt,
            exerciseName: workoutExercise.exerciseName,
            weight: topWeight,
          ),
        );
      }
    }

    points.sort((a, b) => a.date.compareTo(b.date));
    return points;
  }

  Future<WeeklyLoadSummary> getWeeklyLoadSummary(
    Session session,
    int userId,
  ) async {
    final now = DateTime.now().toUtc();
    final currentEnd = now;
    final currentStart = currentEnd.subtract(const Duration(days: 7));
    final previousStart = currentStart.subtract(const Duration(days: 7));

    final current = await _collectLoad(
      session,
      userId,
      currentStart,
      currentEnd,
    );
    final previous = await _collectLoad(
      session,
      userId,
      previousStart,
      currentStart,
    );

    final best = _bestExerciseProgress(current, previous);
    final percentChange = previous.volume <= 0
        ? (current.volume > 0 ? 100.0 : 0.0)
        : ((current.volume - previous.volume) / previous.volume) * 100;

    return WeeklyLoadSummary(
      currentVolume: current.volume,
      previousVolume: previous.volume,
      percentChange: percentChange,
      currentWorkingSets: current.workingSets,
      previousWorkingSets: previous.workingSets,
      recommendedMinSets: 10,
      recommendedMaxSets: 20,
      bestExerciseName: best.name,
      bestExerciseDelta: best.delta,
      bestExerciseCurrentWeight: best.currentWeight,
      currentWeekStart: currentStart,
      currentWeekEnd: currentEnd,
    );
  }

  String _buildStoredVideoName(String fileName) {
    final extension = _safeExtension(fileName);
    final stamp = DateTime.now().microsecondsSinceEpoch;
    return 'set_video_$stamp$extension';
  }

  String _safeExtension(String fileName) {
    final trimmed = fileName.trim().toLowerCase();
    final dotIndex = trimmed.lastIndexOf('.');
    if (dotIndex < 0 || dotIndex == trimmed.length - 1) return '.mp4';

    final extension = trimmed.substring(dotIndex);
    final isSafe = RegExp(r'^\.[a-z0-9]{1,8}$').hasMatch(extension);
    return isSafe ? extension : '.mp4';
  }

  Future<_LoadStats> _collectLoad(
    Session session,
    int userId,
    DateTime start,
    DateTime end,
  ) async {
    final workouts = (await listWorkouts(session, userId))
        .where(
          (workout) =>
              workout.isCompleted &&
              !workout.scheduledAt.isBefore(start) &&
              workout.scheduledAt.isBefore(end),
        )
        .toList();

    var volume = 0.0;
    var workingSets = 0;
    final topWeights = <String, double>{};

    for (final workout in workouts) {
      final workoutId = workout.id;
      if (workoutId == null) continue;

      final workoutExercises = await listWorkoutExercises(session, workoutId);
      for (final workoutExercise in workoutExercises) {
        final workoutExerciseId = workoutExercise.id;
        if (workoutExerciseId == null) continue;

        final sets = await listSets(session, workoutExerciseId);
        for (final set in sets) {
          if (set.weight <= 0 || set.reps <= 0) continue;

          workingSets += 1;
          volume += set.weight * set.reps;

          final exerciseName = workoutExercise.exerciseName;
          final previousTop = topWeights[exerciseName];
          if (previousTop == null || set.weight > previousTop) {
            topWeights[exerciseName] = set.weight;
          }
        }
      }
    }

    return _LoadStats(
      volume: volume,
      workingSets: workingSets,
      topWeights: topWeights,
    );
  }

  _ExerciseProgress _bestExerciseProgress(
    _LoadStats current,
    _LoadStats previous,
  ) {
    String? bestName;
    var bestDelta = 0.0;
    var bestCurrentWeight = 0.0;

    for (final entry in current.topWeights.entries) {
      final previousWeight = previous.topWeights[entry.key];
      if (previousWeight == null) continue;

      final delta = entry.value - previousWeight;
      if (bestName == null || delta > bestDelta) {
        bestName = entry.key;
        bestDelta = delta;
        bestCurrentWeight = entry.value;
      }
    }

    if (bestName == null && current.topWeights.isNotEmpty) {
      final entry = current.topWeights.entries.reduce(
        (a, b) => a.value >= b.value ? a : b,
      );
      bestName = entry.key;
      bestCurrentWeight = entry.value;
    }

    return _ExerciseProgress(
      name: bestName,
      delta: bestDelta,
      currentWeight: bestCurrentWeight,
    );
  }

  Future<void> _ensureExerciseLibrary(Session session) async {
    final existingExercises = await Exercise.db.find(session);

    for (final seed in _exerciseLibrary) {
      Exercise? existingExercise;
      for (final exercise in existingExercises) {
        if (exercise.name == seed.name) {
          existingExercise = exercise;
          break;
        }
      }

      if (existingExercise == null) {
        await Exercise.db.insertRow(session, seed);
      }
    }
  }
}

class _LoadStats {
  final double volume;
  final int workingSets;
  final Map<String, double> topWeights;

  const _LoadStats({
    required this.volume,
    required this.workingSets,
    required this.topWeights,
  });
}

class _ExerciseProgress {
  final String? name;
  final double delta;
  final double currentWeight;

  const _ExerciseProgress({
    required this.name,
    required this.delta,
    required this.currentWeight,
  });
}

final _exerciseLibrary = [
  Exercise(
    name: 'Жим штанги лёжа',
    description:
        'Лягте на скамью так, чтобы стопы уверенно стояли на полу, а голова, верх спины и таз сохраняли опору. Сведите лопатки, опускайте гриф к груди под контролем и выжимайте вверх, не отрывая таз и не теряя положения плеч.',
    mediaUrl: 'assets/exercises/bench_press.png',
    mediaType: 'image',
  ),
  Exercise(
    name: 'Отжимания на брусьях',
    description:
        'Выйдите в упор на брусьях: кисти под плечами, корпус собран, плечи не проваливаются вверх к ушам. Опускайтесь до комфортной глубины и выжимайтесь вверх за счёт разгибания рук, сохраняя движение плавным и без раскачки.',
    mediaUrl: 'assets/exercises/dips.png',
    mediaType: 'image',
  ),
  Exercise(
    name: 'Подъём штанги на бицепс',
    description:
        'Встаньте устойчиво, возьмите штангу нижним хватом и удерживайте локти рядом с корпусом. Поднимайте штангу сгибанием локтей без рывка корпусом, затем медленно опускайте её, сохраняя контроль в нижней фазе.',
    mediaUrl: 'assets/exercises/barbell_curl.png',
    mediaType: 'image',
  ),
  Exercise(
    name: 'Жим гантелей сидя',
    description:
        'Сядьте с опорой для спины и расположите гантели по бокам плеч, удерживая запястья над локтями. Выжимайте гантели вверх до контролируемого выпрямления рук и возвращайте к плечам без прогиба поясницы и запрокидывания головы.',
    mediaUrl: 'assets/exercises/seated_dumbbell_press.png',
    mediaType: 'image',
  ),
  Exercise(
    name: 'Тяга верхнего блока к груди',
    description:
        'Зафиксируйте бёдра под валиком, возьмите рукоять хватом примерно на ширине плеч или чуть шире и слегка отклоните корпус назад. Тяните рукоять к верхней части груди, направляя локти вниз и назад, затем плавно возвращайте вес без раскачки корпуса.',
    mediaUrl: 'assets/exercises/lat_pulldown.png',
    mediaType: 'image',
  ),
  Exercise(
    name: 'Скручивания на скамье',
    description:
        'Закрепите стопы и лягте на скамью, сохраняя поясницу в устойчивом положении. Скручивайте верх корпуса за счёт мышц живота, не тяните шею руками и опускайтесь обратно медленно, без падения на скамью.',
    mediaUrl: 'assets/exercises/bench_crunch.png',
    mediaType: 'image',
  ),
  Exercise(
    name: 'Приседания со штангой',
    description:
        'Поставьте стопы примерно на ширине плеч, гриф держите стабильно на верхней части спины, а корпус сохраняйте напряжённым. Начинайте движение с отведения таза и сгибания коленей по линии стоп, затем поднимайтесь вверх, сохраняя пятки на полу и нейтральное положение спины.',
    mediaUrl: 'assets/exercises/barbell_squat.png',
    mediaType: 'image',
  ),
  Exercise(
    name: 'Жим ногами в тренажёре',
    description:
        'Сядьте так, чтобы спина была плотно прижата к опоре, а стопы полностью стояли на платформе. Выжимайте платформу разгибанием коленей и тазобедренных суставов, затем опускайте её до комфортной глубины, не отрывая пятки и не сводя колени внутрь.',
    mediaUrl: 'assets/exercises/leg_press.png',
    mediaType: 'image',
  ),
];
