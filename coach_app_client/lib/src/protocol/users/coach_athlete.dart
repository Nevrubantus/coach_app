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

abstract class CoachAthlete implements _i1.SerializableModel {
  CoachAthlete._({
    this.id,
    required this.coachId,
    required this.athleteId,
    required this.createdAt,
  });

  factory CoachAthlete({
    int? id,
    required int coachId,
    required int athleteId,
    required DateTime createdAt,
  }) = _CoachAthleteImpl;

  factory CoachAthlete.fromJson(Map<String, dynamic> jsonSerialization) {
    return CoachAthlete(
      id: jsonSerialization['id'] as int?,
      coachId: jsonSerialization['coachId'] as int,
      athleteId: jsonSerialization['athleteId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int coachId;

  int athleteId;

  DateTime createdAt;

  /// Returns a shallow copy of this [CoachAthlete]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CoachAthlete copyWith({
    int? id,
    int? coachId,
    int? athleteId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CoachAthlete',
      if (id != null) 'id': id,
      'coachId': coachId,
      'athleteId': athleteId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CoachAthleteImpl extends CoachAthlete {
  _CoachAthleteImpl({
    int? id,
    required int coachId,
    required int athleteId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         coachId: coachId,
         athleteId: athleteId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CoachAthlete]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CoachAthlete copyWith({
    Object? id = _Undefined,
    int? coachId,
    int? athleteId,
    DateTime? createdAt,
  }) {
    return CoachAthlete(
      id: id is int? ? id : this.id,
      coachId: coachId ?? this.coachId,
      athleteId: athleteId ?? this.athleteId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
