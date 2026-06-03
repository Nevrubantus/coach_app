import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

Future<bool> deleteWorkoutCascade(Session session, int workoutId) async {
  final workout = await Workout.db.findById(session, workoutId);
  if (workout == null) return false;

  final videos = await WorkoutVideo.db.find(
    session,
    where: (t) => t.workoutId.equals(workoutId),
  );

  for (final video in videos) {
    final videoId = video.id;
    if (videoId != null) {
      final comments = await VideoComment.db.find(
        session,
        where: (t) => t.videoId.equals(videoId),
      );
      if (comments.isNotEmpty) {
        await VideoComment.db.delete(session, comments);
      }
    }

    await _deleteVideoFile(video.filePath);
  }

  if (videos.isNotEmpty) {
    await WorkoutVideo.db.delete(session, videos);
  }

  final workoutExercises = await WorkoutExercise.db.find(
    session,
    where: (t) => t.workoutId.equals(workoutId),
  );

  for (final workoutExercise in workoutExercises) {
    final workoutExerciseId = workoutExercise.id;
    if (workoutExerciseId == null) continue;

    final sets = await WorkoutSet.db.find(
      session,
      where: (t) => t.workoutExerciseId.equals(workoutExerciseId),
    );
    if (sets.isNotEmpty) {
      await WorkoutSet.db.delete(session, sets);
    }
  }

  if (workoutExercises.isNotEmpty) {
    await WorkoutExercise.db.delete(session, workoutExercises);
  }

  await Workout.db.deleteRow(session, workout);
  return true;
}

Future<void> _deleteVideoFile(String filePath) async {
  if (filePath.contains('..')) return;

  final file = File('web/static/$filePath');
  try {
    if (await file.exists()) {
      await file.delete();
    }
  } catch (_) {
    // A missing local file should not block deleting the workout from the demo DB.
  }
}
