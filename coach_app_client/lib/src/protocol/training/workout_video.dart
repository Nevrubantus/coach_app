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

abstract class WorkoutVideo implements _i1.SerializableModel {
  WorkoutVideo._({
    this.id,
    required this.workoutId,
    required this.workoutExerciseId,
    required this.workoutSetId,
    required this.athleteId,
    required this.fileName,
    required this.filePath,
    required this.uploadedAt,
  });

  factory WorkoutVideo({
    int? id,
    required int workoutId,
    required int workoutExerciseId,
    required int workoutSetId,
    required int athleteId,
    required String fileName,
    required String filePath,
    required DateTime uploadedAt,
  }) = _WorkoutVideoImpl;

  factory WorkoutVideo.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutVideo(
      id: jsonSerialization['id'] as int?,
      workoutId: jsonSerialization['workoutId'] as int,
      workoutExerciseId: jsonSerialization['workoutExerciseId'] as int,
      workoutSetId: jsonSerialization['workoutSetId'] as int,
      athleteId: jsonSerialization['athleteId'] as int,
      fileName: jsonSerialization['fileName'] as String,
      filePath: jsonSerialization['filePath'] as String,
      uploadedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['uploadedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workoutId;

  int workoutExerciseId;

  int workoutSetId;

  int athleteId;

  String fileName;

  String filePath;

  DateTime uploadedAt;

  /// Returns a shallow copy of this [WorkoutVideo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutVideo copyWith({
    int? id,
    int? workoutId,
    int? workoutExerciseId,
    int? workoutSetId,
    int? athleteId,
    String? fileName,
    String? filePath,
    DateTime? uploadedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutVideo',
      if (id != null) 'id': id,
      'workoutId': workoutId,
      'workoutExerciseId': workoutExerciseId,
      'workoutSetId': workoutSetId,
      'athleteId': athleteId,
      'fileName': fileName,
      'filePath': filePath,
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutVideoImpl extends WorkoutVideo {
  _WorkoutVideoImpl({
    int? id,
    required int workoutId,
    required int workoutExerciseId,
    required int workoutSetId,
    required int athleteId,
    required String fileName,
    required String filePath,
    required DateTime uploadedAt,
  }) : super._(
         id: id,
         workoutId: workoutId,
         workoutExerciseId: workoutExerciseId,
         workoutSetId: workoutSetId,
         athleteId: athleteId,
         fileName: fileName,
         filePath: filePath,
         uploadedAt: uploadedAt,
       );

  /// Returns a shallow copy of this [WorkoutVideo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutVideo copyWith({
    Object? id = _Undefined,
    int? workoutId,
    int? workoutExerciseId,
    int? workoutSetId,
    int? athleteId,
    String? fileName,
    String? filePath,
    DateTime? uploadedAt,
  }) {
    return WorkoutVideo(
      id: id is int? ? id : this.id,
      workoutId: workoutId ?? this.workoutId,
      workoutExerciseId: workoutExerciseId ?? this.workoutExerciseId,
      workoutSetId: workoutSetId ?? this.workoutSetId,
      athleteId: athleteId ?? this.athleteId,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
