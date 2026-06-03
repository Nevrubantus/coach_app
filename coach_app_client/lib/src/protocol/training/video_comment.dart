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

abstract class VideoComment implements _i1.SerializableModel {
  VideoComment._({
    this.id,
    required this.videoId,
    required this.coachId,
    required this.coachName,
    required this.text,
    required this.createdAt,
  });

  factory VideoComment({
    int? id,
    required int videoId,
    required int coachId,
    required String coachName,
    required String text,
    required DateTime createdAt,
  }) = _VideoCommentImpl;

  factory VideoComment.fromJson(Map<String, dynamic> jsonSerialization) {
    return VideoComment(
      id: jsonSerialization['id'] as int?,
      videoId: jsonSerialization['videoId'] as int,
      coachId: jsonSerialization['coachId'] as int,
      coachName: jsonSerialization['coachName'] as String,
      text: jsonSerialization['text'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int videoId;

  int coachId;

  String coachName;

  String text;

  DateTime createdAt;

  /// Returns a shallow copy of this [VideoComment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VideoComment copyWith({
    int? id,
    int? videoId,
    int? coachId,
    String? coachName,
    String? text,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VideoComment',
      if (id != null) 'id': id,
      'videoId': videoId,
      'coachId': coachId,
      'coachName': coachName,
      'text': text,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VideoCommentImpl extends VideoComment {
  _VideoCommentImpl({
    int? id,
    required int videoId,
    required int coachId,
    required String coachName,
    required String text,
    required DateTime createdAt,
  }) : super._(
         id: id,
         videoId: videoId,
         coachId: coachId,
         coachName: coachName,
         text: text,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VideoComment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VideoComment copyWith({
    Object? id = _Undefined,
    int? videoId,
    int? coachId,
    String? coachName,
    String? text,
    DateTime? createdAt,
  }) {
    return VideoComment(
      id: id is int? ? id : this.id,
      videoId: videoId ?? this.videoId,
      coachId: coachId ?? this.coachId,
      coachName: coachName ?? this.coachName,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
