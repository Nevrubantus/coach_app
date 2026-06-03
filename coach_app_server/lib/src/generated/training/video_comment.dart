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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class VideoComment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = VideoCommentTable();

  static const db = VideoCommentRepository._();

  @override
  int? id;

  int videoId;

  int coachId;

  String coachName;

  String text;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static VideoCommentInclude include() {
    return VideoCommentInclude._();
  }

  static VideoCommentIncludeList includeList({
    _i1.WhereExpressionBuilder<VideoCommentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoCommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoCommentTable>? orderByList,
    VideoCommentInclude? include,
  }) {
    return VideoCommentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VideoComment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(VideoComment.t),
      include: include,
    );
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

class VideoCommentUpdateTable extends _i1.UpdateTable<VideoCommentTable> {
  VideoCommentUpdateTable(super.table);

  _i1.ColumnValue<int, int> videoId(int value) => _i1.ColumnValue(
    table.videoId,
    value,
  );

  _i1.ColumnValue<int, int> coachId(int value) => _i1.ColumnValue(
    table.coachId,
    value,
  );

  _i1.ColumnValue<String, String> coachName(String value) => _i1.ColumnValue(
    table.coachName,
    value,
  );

  _i1.ColumnValue<String, String> text(String value) => _i1.ColumnValue(
    table.text,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class VideoCommentTable extends _i1.Table<int?> {
  VideoCommentTable({super.tableRelation}) : super(tableName: 'video_comment') {
    updateTable = VideoCommentUpdateTable(this);
    videoId = _i1.ColumnInt(
      'videoId',
      this,
    );
    coachId = _i1.ColumnInt(
      'coachId',
      this,
    );
    coachName = _i1.ColumnString(
      'coachName',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final VideoCommentUpdateTable updateTable;

  late final _i1.ColumnInt videoId;

  late final _i1.ColumnInt coachId;

  late final _i1.ColumnString coachName;

  late final _i1.ColumnString text;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    videoId,
    coachId,
    coachName,
    text,
    createdAt,
  ];
}

class VideoCommentInclude extends _i1.IncludeObject {
  VideoCommentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => VideoComment.t;
}

class VideoCommentIncludeList extends _i1.IncludeList {
  VideoCommentIncludeList._({
    _i1.WhereExpressionBuilder<VideoCommentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VideoComment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => VideoComment.t;
}

class VideoCommentRepository {
  const VideoCommentRepository._();

  /// Returns a list of [VideoComment]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<VideoComment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoCommentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoCommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoCommentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VideoComment>(
      where: where?.call(VideoComment.t),
      orderBy: orderBy?.call(VideoComment.t),
      orderByList: orderByList?.call(VideoComment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VideoComment] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<VideoComment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoCommentTable>? where,
    int? offset,
    _i1.OrderByBuilder<VideoCommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoCommentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VideoComment>(
      where: where?.call(VideoComment.t),
      orderBy: orderBy?.call(VideoComment.t),
      orderByList: orderByList?.call(VideoComment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VideoComment] by its [id] or null if no such row exists.
  Future<VideoComment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VideoComment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VideoComment]s in the list and returns the inserted rows.
  ///
  /// The returned [VideoComment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<VideoComment>> insert(
    _i1.DatabaseSession session,
    List<VideoComment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<VideoComment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [VideoComment] and returns the inserted row.
  ///
  /// The returned [VideoComment] will have its `id` field set.
  Future<VideoComment> insertRow(
    _i1.DatabaseSession session,
    VideoComment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<VideoComment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [VideoComment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<VideoComment>> update(
    _i1.DatabaseSession session,
    List<VideoComment> rows, {
    _i1.ColumnSelections<VideoCommentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<VideoComment>(
      rows,
      columns: columns?.call(VideoComment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VideoComment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VideoComment> updateRow(
    _i1.DatabaseSession session,
    VideoComment row, {
    _i1.ColumnSelections<VideoCommentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<VideoComment>(
      row,
      columns: columns?.call(VideoComment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VideoComment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VideoComment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<VideoCommentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<VideoComment>(
      id,
      columnValues: columnValues(VideoComment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VideoComment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<VideoComment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<VideoCommentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<VideoCommentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoCommentTable>? orderBy,
    _i1.OrderByListBuilder<VideoCommentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<VideoComment>(
      columnValues: columnValues(VideoComment.t.updateTable),
      where: where(VideoComment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VideoComment.t),
      orderByList: orderByList?.call(VideoComment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [VideoComment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<VideoComment>> delete(
    _i1.DatabaseSession session,
    List<VideoComment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<VideoComment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [VideoComment].
  Future<VideoComment> deleteRow(
    _i1.DatabaseSession session,
    VideoComment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VideoComment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<VideoComment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VideoCommentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<VideoComment>(
      where: where(VideoComment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoCommentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<VideoComment>(
      where: where?.call(VideoComment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VideoComment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VideoCommentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VideoComment>(
      where: where(VideoComment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
