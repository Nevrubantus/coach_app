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

abstract class Workout implements _i1.SerializableModel {
  Workout._({
    this.id,
    required this.userId,
    required this.title,
    required this.scheduledAt,
    this.durationMinutes,
    this.notes,
    required this.isCompleted,
  });

  factory Workout({
    int? id,
    required int userId,
    required String title,
    required DateTime scheduledAt,
    int? durationMinutes,
    String? notes,
    required bool isCompleted,
  }) = _WorkoutImpl;

  factory Workout.fromJson(Map<String, dynamic> jsonSerialization) {
    return Workout(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      scheduledAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledAt'],
      ),
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
      notes: jsonSerialization['notes'] as String?,
      isCompleted: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isCompleted'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String title;

  DateTime scheduledAt;

  int? durationMinutes;

  String? notes;

  bool isCompleted;

  /// Returns a shallow copy of this [Workout]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Workout copyWith({
    int? id,
    int? userId,
    String? title,
    DateTime? scheduledAt,
    int? durationMinutes,
    String? notes,
    bool? isCompleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Workout',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'scheduledAt': scheduledAt.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      if (notes != null) 'notes': notes,
      'isCompleted': isCompleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutImpl extends Workout {
  _WorkoutImpl({
    int? id,
    required int userId,
    required String title,
    required DateTime scheduledAt,
    int? durationMinutes,
    String? notes,
    required bool isCompleted,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         scheduledAt: scheduledAt,
         durationMinutes: durationMinutes,
         notes: notes,
         isCompleted: isCompleted,
       );

  /// Returns a shallow copy of this [Workout]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Workout copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    DateTime? scheduledAt,
    Object? durationMinutes = _Undefined,
    Object? notes = _Undefined,
    bool? isCompleted,
  }) {
    return Workout(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      durationMinutes: durationMinutes is int?
          ? durationMinutes
          : this.durationMinutes,
      notes: notes is String? ? notes : this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
