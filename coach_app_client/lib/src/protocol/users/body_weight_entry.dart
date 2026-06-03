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

abstract class BodyWeightEntry implements _i1.SerializableModel {
  BodyWeightEntry._({
    this.id,
    required this.userId,
    required this.weight,
    required this.measuredAt,
  });

  factory BodyWeightEntry({
    int? id,
    required int userId,
    required double weight,
    required DateTime measuredAt,
  }) = _BodyWeightEntryImpl;

  factory BodyWeightEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return BodyWeightEntry(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      measuredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['measuredAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  double weight;

  DateTime measuredAt;

  /// Returns a shallow copy of this [BodyWeightEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BodyWeightEntry copyWith({
    int? id,
    int? userId,
    double? weight,
    DateTime? measuredAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BodyWeightEntry',
      if (id != null) 'id': id,
      'userId': userId,
      'weight': weight,
      'measuredAt': measuredAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BodyWeightEntryImpl extends BodyWeightEntry {
  _BodyWeightEntryImpl({
    int? id,
    required int userId,
    required double weight,
    required DateTime measuredAt,
  }) : super._(
         id: id,
         userId: userId,
         weight: weight,
         measuredAt: measuredAt,
       );

  /// Returns a shallow copy of this [BodyWeightEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BodyWeightEntry copyWith({
    Object? id = _Undefined,
    int? userId,
    double? weight,
    DateTime? measuredAt,
  }) {
    return BodyWeightEntry(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      weight: weight ?? this.weight,
      measuredAt: measuredAt ?? this.measuredAt,
    );
  }
}
