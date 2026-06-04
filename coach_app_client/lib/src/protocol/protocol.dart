/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'training/exercise.dart' as _i2;
import 'training/progress_point.dart' as _i3;
import 'training/video_comment.dart' as _i4;
import 'training/weekly_load_summary.dart' as _i5;
import 'training/workout.dart' as _i6;
import 'training/workout_exercise.dart' as _i7;
import 'training/workout_set.dart' as _i8;
import 'training/workout_video.dart' as _i9;
import 'users/body_weight_entry.dart' as _i10;
import 'users/coach_athlete.dart' as _i11;
import 'users/user.dart' as _i12;
import 'package:coach_app_client/src/protocol/users/user.dart' as _i13;
import 'package:coach_app_client/src/protocol/training/workout.dart' as _i14;
import 'package:coach_app_client/src/protocol/training/exercise.dart' as _i15;
import 'package:coach_app_client/src/protocol/training/workout_exercise.dart'
    as _i16;
import 'package:coach_app_client/src/protocol/training/workout_set.dart'
    as _i17;
import 'package:coach_app_client/src/protocol/training/workout_video.dart'
    as _i18;
import 'package:coach_app_client/src/protocol/training/video_comment.dart'
    as _i19;
import 'package:coach_app_client/src/protocol/training/progress_point.dart'
    as _i20;
import 'package:coach_app_client/src/protocol/users/body_weight_entry.dart'
    as _i21;
export 'training/exercise.dart';
export 'training/progress_point.dart';
export 'training/video_comment.dart';
export 'training/weekly_load_summary.dart';
export 'training/workout.dart';
export 'training/workout_exercise.dart';
export 'training/workout_set.dart';
export 'training/workout_video.dart';
export 'users/body_weight_entry.dart';
export 'users/coach_athlete.dart';
export 'users/user.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Exercise) {
      return _i2.Exercise.fromJson(data) as T;
    }
    if (t == _i3.ProgressPoint) {
      return _i3.ProgressPoint.fromJson(data) as T;
    }
    if (t == _i4.VideoComment) {
      return _i4.VideoComment.fromJson(data) as T;
    }
    if (t == _i5.WeeklyLoadSummary) {
      return _i5.WeeklyLoadSummary.fromJson(data) as T;
    }
    if (t == _i6.Workout) {
      return _i6.Workout.fromJson(data) as T;
    }
    if (t == _i7.WorkoutExercise) {
      return _i7.WorkoutExercise.fromJson(data) as T;
    }
    if (t == _i8.WorkoutSet) {
      return _i8.WorkoutSet.fromJson(data) as T;
    }
    if (t == _i9.WorkoutVideo) {
      return _i9.WorkoutVideo.fromJson(data) as T;
    }
    if (t == _i10.BodyWeightEntry) {
      return _i10.BodyWeightEntry.fromJson(data) as T;
    }
    if (t == _i11.CoachAthlete) {
      return _i11.CoachAthlete.fromJson(data) as T;
    }
    if (t == _i12.User) {
      return _i12.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Exercise?>()) {
      return (data != null ? _i2.Exercise.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ProgressPoint?>()) {
      return (data != null ? _i3.ProgressPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.VideoComment?>()) {
      return (data != null ? _i4.VideoComment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.WeeklyLoadSummary?>()) {
      return (data != null ? _i5.WeeklyLoadSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Workout?>()) {
      return (data != null ? _i6.Workout.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.WorkoutExercise?>()) {
      return (data != null ? _i7.WorkoutExercise.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.WorkoutSet?>()) {
      return (data != null ? _i8.WorkoutSet.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.WorkoutVideo?>()) {
      return (data != null ? _i9.WorkoutVideo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.BodyWeightEntry?>()) {
      return (data != null ? _i10.BodyWeightEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CoachAthlete?>()) {
      return (data != null ? _i11.CoachAthlete.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.User?>()) {
      return (data != null ? _i12.User.fromJson(data) : null) as T;
    }
    if (t == List<_i13.User>) {
      return (data as List).map((e) => deserialize<_i13.User>(e)).toList() as T;
    }
    if (t == List<_i14.Workout>) {
      return (data as List).map((e) => deserialize<_i14.Workout>(e)).toList()
          as T;
    }
    if (t == List<_i15.Exercise>) {
      return (data as List).map((e) => deserialize<_i15.Exercise>(e)).toList()
          as T;
    }
    if (t == List<_i16.WorkoutExercise>) {
      return (data as List)
              .map((e) => deserialize<_i16.WorkoutExercise>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.WorkoutSet>) {
      return (data as List).map((e) => deserialize<_i17.WorkoutSet>(e)).toList()
          as T;
    }
    if (t == List<_i18.WorkoutVideo>) {
      return (data as List)
              .map((e) => deserialize<_i18.WorkoutVideo>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.VideoComment>) {
      return (data as List)
              .map((e) => deserialize<_i19.VideoComment>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.ProgressPoint>) {
      return (data as List)
              .map((e) => deserialize<_i20.ProgressPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.BodyWeightEntry>) {
      return (data as List)
              .map((e) => deserialize<_i21.BodyWeightEntry>(e))
              .toList()
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Exercise => 'Exercise',
      _i3.ProgressPoint => 'ProgressPoint',
      _i4.VideoComment => 'VideoComment',
      _i5.WeeklyLoadSummary => 'WeeklyLoadSummary',
      _i6.Workout => 'Workout',
      _i7.WorkoutExercise => 'WorkoutExercise',
      _i8.WorkoutSet => 'WorkoutSet',
      _i9.WorkoutVideo => 'WorkoutVideo',
      _i10.BodyWeightEntry => 'BodyWeightEntry',
      _i11.CoachAthlete => 'CoachAthlete',
      _i12.User => 'User',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('coach_app.', '');
    }

    switch (data) {
      case _i2.Exercise():
        return 'Exercise';
      case _i3.ProgressPoint():
        return 'ProgressPoint';
      case _i4.VideoComment():
        return 'VideoComment';
      case _i5.WeeklyLoadSummary():
        return 'WeeklyLoadSummary';
      case _i6.Workout():
        return 'Workout';
      case _i7.WorkoutExercise():
        return 'WorkoutExercise';
      case _i8.WorkoutSet():
        return 'WorkoutSet';
      case _i9.WorkoutVideo():
        return 'WorkoutVideo';
      case _i10.BodyWeightEntry():
        return 'BodyWeightEntry';
      case _i11.CoachAthlete():
        return 'CoachAthlete';
      case _i12.User():
        return 'User';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Exercise') {
      return deserialize<_i2.Exercise>(data['data']);
    }
    if (dataClassName == 'ProgressPoint') {
      return deserialize<_i3.ProgressPoint>(data['data']);
    }
    if (dataClassName == 'VideoComment') {
      return deserialize<_i4.VideoComment>(data['data']);
    }
    if (dataClassName == 'WeeklyLoadSummary') {
      return deserialize<_i5.WeeklyLoadSummary>(data['data']);
    }
    if (dataClassName == 'Workout') {
      return deserialize<_i6.Workout>(data['data']);
    }
    if (dataClassName == 'WorkoutExercise') {
      return deserialize<_i7.WorkoutExercise>(data['data']);
    }
    if (dataClassName == 'WorkoutSet') {
      return deserialize<_i8.WorkoutSet>(data['data']);
    }
    if (dataClassName == 'WorkoutVideo') {
      return deserialize<_i9.WorkoutVideo>(data['data']);
    }
    if (dataClassName == 'BodyWeightEntry') {
      return deserialize<_i10.BodyWeightEntry>(data['data']);
    }
    if (dataClassName == 'CoachAthlete') {
      return deserialize<_i11.CoachAthlete>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i12.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
