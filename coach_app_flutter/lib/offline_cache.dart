import 'dart:convert';

import 'package:coach_app_client/coach_app_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineCache {
  static Future<List<Exercise>> readExercises() {
    return _readList(_exercisesKey, Exercise.fromJson);
  }

  static Future<void> saveExercises(List<Exercise> exercises) {
    return _writeList(_exercisesKey, exercises.map((item) => item.toJson()));
  }

  static Future<List<Workout>> readWorkoutsForMonth(
    int userId,
    DateTime month,
  ) {
    return _readList(_workoutsMonthKey(userId, month), Workout.fromJson);
  }

  static Future<void> saveWorkoutsForMonth(
    int userId,
    DateTime month,
    List<Workout> workouts,
  ) {
    return _writeList(
      _workoutsMonthKey(userId, month),
      workouts.map((item) => item.toJson()),
    );
  }

  static Future<Workout?> readUpcomingWorkout(int userId) {
    return _readObject(_upcomingWorkoutKey(userId), Workout.fromJson);
  }

  static Future<void> saveUpcomingWorkout(int userId, Workout? workout) {
    return _writeObject(_upcomingWorkoutKey(userId), workout?.toJson());
  }

  static Future<List<WorkoutExercise>> readWorkoutExercises(int workoutId) {
    return _readList(
      _workoutExercisesKey(workoutId),
      WorkoutExercise.fromJson,
    );
  }

  static Future<void> saveWorkoutExercises(
    int workoutId,
    List<WorkoutExercise> exercises,
  ) {
    return _writeList(
      _workoutExercisesKey(workoutId),
      exercises.map((item) => item.toJson()),
    );
  }

  static Future<List<WorkoutSet>> readSets(int workoutExerciseId) {
    return _readList(_setsKey(workoutExerciseId), WorkoutSet.fromJson);
  }

  static Future<void> saveSets(
    int workoutExerciseId,
    List<WorkoutSet> sets,
  ) {
    return _writeList(
      _setsKey(workoutExerciseId),
      sets.map((item) => item.toJson()),
    );
  }

  static Future<List<ProgressPoint>> readProgress(int userId) {
    return _readList(_progressKey(userId), ProgressPoint.fromJson);
  }

  static Future<void> saveProgress(
    int userId,
    List<ProgressPoint> points,
  ) {
    return _writeList(_progressKey(userId), points.map((item) => item.toJson()));
  }

  static Future<List<BodyWeightEntry>> readBodyWeights(int userId) {
    return _readList(_bodyWeightsKey(userId), BodyWeightEntry.fromJson);
  }

  static Future<void> saveBodyWeights(
    int userId,
    List<BodyWeightEntry> entries,
  ) {
    return _writeList(
      _bodyWeightsKey(userId),
      entries.map((item) => item.toJson()),
    );
  }

  static Future<List<T>> _readList<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final source = prefs.getString(key);
    if (source == null || source.isEmpty) return [];

    try {
      final decoded = jsonDecode(source) as List<dynamic>;
      return decoded
          .map((item) => fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<T?> _readObject<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final source = prefs.getString(key);
    if (source == null || source.isEmpty) return null;

    try {
      return fromJson(Map<String, dynamic>.from(jsonDecode(source) as Map));
    } catch (_) {
      return null;
    }
  }

  static Future<void> _writeList(
    String key,
    Iterable<Map<String, dynamic>> values,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(values.toList()));
  }

  static Future<void> _writeObject(
    String key,
    Map<String, dynamic>? value,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(key);
      return;
    }

    await prefs.setString(key, jsonEncode(value));
  }

  static const _exercisesKey = 'offline_exercises';

  static String _workoutsMonthKey(int userId, DateTime month) {
    final monthPart = month.month.toString().padLeft(2, '0');
    return 'offline_workouts_${userId}_${month.year}_$monthPart';
  }

  static String _upcomingWorkoutKey(int userId) {
    return 'offline_upcoming_workout_$userId';
  }

  static String _workoutExercisesKey(int workoutId) {
    return 'offline_workout_exercises_$workoutId';
  }

  static String _setsKey(int workoutExerciseId) {
    return 'offline_sets_$workoutExerciseId';
  }

  static String _progressKey(int userId) {
    return 'offline_progress_$userId';
  }

  static String _bodyWeightsKey(int userId) {
    return 'offline_body_weights_$userId';
  }
}
