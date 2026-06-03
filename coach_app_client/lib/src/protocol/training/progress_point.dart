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

abstract class ProgressPoint implements _i1.SerializableModel {
  ProgressPoint._({
    required this.date,
    required this.exerciseName,
    required this.weight,
  });

  factory ProgressPoint({
    required DateTime date,
    required String exerciseName,
    required double weight,
  }) = _ProgressPointImpl;

  factory ProgressPoint.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProgressPoint(
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      exerciseName: jsonSerialization['exerciseName'] as String,
      weight: (jsonSerialization['weight'] as num).toDouble(),
    );
  }

  DateTime date;

  String exerciseName;

  double weight;

  /// Returns a shallow copy of this [ProgressPoint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProgressPoint copyWith({
    DateTime? date,
    String? exerciseName,
    double? weight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProgressPoint',
      'date': date.toJson(),
      'exerciseName': exerciseName,
      'weight': weight,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ProgressPointImpl extends ProgressPoint {
  _ProgressPointImpl({
    required DateTime date,
    required String exerciseName,
    required double weight,
  }) : super._(
         date: date,
         exerciseName: exerciseName,
         weight: weight,
       );

  /// Returns a shallow copy of this [ProgressPoint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProgressPoint copyWith({
    DateTime? date,
    String? exerciseName,
    double? weight,
  }) {
    return ProgressPoint(
      date: date ?? this.date,
      exerciseName: exerciseName ?? this.exerciseName,
      weight: weight ?? this.weight,
    );
  }
}
