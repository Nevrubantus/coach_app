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

abstract class WorkoutSet implements _i1.SerializableModel {
  WorkoutSet._({
    this.id,
    required this.workoutExerciseId,
    required this.setIndex,
    required this.weight,
    required this.reps,
    this.notes,
    required this.createdAt,
  });

  factory WorkoutSet({
    int? id,
    required int workoutExerciseId,
    required int setIndex,
    required double weight,
    required int reps,
    String? notes,
    required DateTime createdAt,
  }) = _WorkoutSetImpl;

  factory WorkoutSet.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutSet(
      id: jsonSerialization['id'] as int?,
      workoutExerciseId: jsonSerialization['workoutExerciseId'] as int,
      setIndex: jsonSerialization['setIndex'] as int,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      reps: jsonSerialization['reps'] as int,
      notes: jsonSerialization['notes'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workoutExerciseId;

  int setIndex;

  double weight;

  int reps;

  String? notes;

  DateTime createdAt;

  /// Returns a shallow copy of this [WorkoutSet]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutSet copyWith({
    int? id,
    int? workoutExerciseId,
    int? setIndex,
    double? weight,
    int? reps,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutSet',
      if (id != null) 'id': id,
      'workoutExerciseId': workoutExerciseId,
      'setIndex': setIndex,
      'weight': weight,
      'reps': reps,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutSetImpl extends WorkoutSet {
  _WorkoutSetImpl({
    int? id,
    required int workoutExerciseId,
    required int setIndex,
    required double weight,
    required int reps,
    String? notes,
    required DateTime createdAt,
  }) : super._(
         id: id,
         workoutExerciseId: workoutExerciseId,
         setIndex: setIndex,
         weight: weight,
         reps: reps,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [WorkoutSet]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutSet copyWith({
    Object? id = _Undefined,
    int? workoutExerciseId,
    int? setIndex,
    double? weight,
    int? reps,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return WorkoutSet(
      id: id is int? ? id : this.id,
      workoutExerciseId: workoutExerciseId ?? this.workoutExerciseId,
      setIndex: setIndex ?? this.setIndex,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
