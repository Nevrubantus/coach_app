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

abstract class WorkoutVideo
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = WorkoutVideoTable();

  static const db = WorkoutVideoRepository._();

  @override
  int? id;

  int workoutId;

  int workoutExerciseId;

  int workoutSetId;

  int athleteId;

  String fileName;

  String filePath;

  DateTime uploadedAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static WorkoutVideoInclude include() {
    return WorkoutVideoInclude._();
  }

  static WorkoutVideoIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkoutVideoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutVideoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutVideoTable>? orderByList,
    WorkoutVideoInclude? include,
  }) {
    return WorkoutVideoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutVideo.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkoutVideo.t),
      include: include,
    );
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

class WorkoutVideoUpdateTable extends _i1.UpdateTable<WorkoutVideoTable> {
  WorkoutVideoUpdateTable(super.table);

  _i1.ColumnValue<int, int> workoutId(int value) => _i1.ColumnValue(
    table.workoutId,
    value,
  );

  _i1.ColumnValue<int, int> workoutExerciseId(int value) => _i1.ColumnValue(
    table.workoutExerciseId,
    value,
  );

  _i1.ColumnValue<int, int> workoutSetId(int value) => _i1.ColumnValue(
    table.workoutSetId,
    value,
  );

  _i1.ColumnValue<int, int> athleteId(int value) => _i1.ColumnValue(
    table.athleteId,
    value,
  );

  _i1.ColumnValue<String, String> fileName(String value) => _i1.ColumnValue(
    table.fileName,
    value,
  );

  _i1.ColumnValue<String, String> filePath(String value) => _i1.ColumnValue(
    table.filePath,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> uploadedAt(DateTime value) =>
      _i1.ColumnValue(
        table.uploadedAt,
        value,
      );
}

class WorkoutVideoTable extends _i1.Table<int?> {
  WorkoutVideoTable({super.tableRelation}) : super(tableName: 'workout_video') {
    updateTable = WorkoutVideoUpdateTable(this);
    workoutId = _i1.ColumnInt(
      'workoutId',
      this,
    );
    workoutExerciseId = _i1.ColumnInt(
      'workoutExerciseId',
      this,
    );
    workoutSetId = _i1.ColumnInt(
      'workoutSetId',
      this,
    );
    athleteId = _i1.ColumnInt(
      'athleteId',
      this,
    );
    fileName = _i1.ColumnString(
      'fileName',
      this,
    );
    filePath = _i1.ColumnString(
      'filePath',
      this,
    );
    uploadedAt = _i1.ColumnDateTime(
      'uploadedAt',
      this,
    );
  }

  late final WorkoutVideoUpdateTable updateTable;

  late final _i1.ColumnInt workoutId;

  late final _i1.ColumnInt workoutExerciseId;

  late final _i1.ColumnInt workoutSetId;

  late final _i1.ColumnInt athleteId;

  late final _i1.ColumnString fileName;

  late final _i1.ColumnString filePath;

  late final _i1.ColumnDateTime uploadedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    workoutId,
    workoutExerciseId,
    workoutSetId,
    athleteId,
    fileName,
    filePath,
    uploadedAt,
  ];
}

class WorkoutVideoInclude extends _i1.IncludeObject {
  WorkoutVideoInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WorkoutVideo.t;
}

class WorkoutVideoIncludeList extends _i1.IncludeList {
  WorkoutVideoIncludeList._({
    _i1.WhereExpressionBuilder<WorkoutVideoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutVideo.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WorkoutVideo.t;
}

class WorkoutVideoRepository {
  const WorkoutVideoRepository._();

  /// Returns a list of [WorkoutVideo]s matching the given query parameters.
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
  Future<List<WorkoutVideo>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutVideoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutVideoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutVideoTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutVideo>(
      where: where?.call(WorkoutVideo.t),
      orderBy: orderBy?.call(WorkoutVideo.t),
      orderByList: orderByList?.call(WorkoutVideo.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutVideo] matching the given query parameters.
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
  Future<WorkoutVideo?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutVideoTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkoutVideoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutVideoTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutVideo>(
      where: where?.call(WorkoutVideo.t),
      orderBy: orderBy?.call(WorkoutVideo.t),
      orderByList: orderByList?.call(WorkoutVideo.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutVideo] by its [id] or null if no such row exists.
  Future<WorkoutVideo?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutVideo>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutVideo]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutVideo]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WorkoutVideo>> insert(
    _i1.DatabaseSession session,
    List<WorkoutVideo> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WorkoutVideo>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WorkoutVideo] and returns the inserted row.
  ///
  /// The returned [WorkoutVideo] will have its `id` field set.
  Future<WorkoutVideo> insertRow(
    _i1.DatabaseSession session,
    WorkoutVideo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutVideo>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutVideo]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkoutVideo>> update(
    _i1.DatabaseSession session,
    List<WorkoutVideo> rows, {
    _i1.ColumnSelections<WorkoutVideoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkoutVideo>(
      rows,
      columns: columns?.call(WorkoutVideo.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutVideo]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutVideo> updateRow(
    _i1.DatabaseSession session,
    WorkoutVideo row, {
    _i1.ColumnSelections<WorkoutVideoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutVideo>(
      row,
      columns: columns?.call(WorkoutVideo.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutVideo] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutVideo?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkoutVideoUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutVideo>(
      id,
      columnValues: columnValues(WorkoutVideo.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutVideo]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkoutVideo>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WorkoutVideoUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WorkoutVideoTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutVideoTable>? orderBy,
    _i1.OrderByListBuilder<WorkoutVideoTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkoutVideo>(
      columnValues: columnValues(WorkoutVideo.t.updateTable),
      where: where(WorkoutVideo.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutVideo.t),
      orderByList: orderByList?.call(WorkoutVideo.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkoutVideo]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkoutVideo>> delete(
    _i1.DatabaseSession session,
    List<WorkoutVideo> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkoutVideo>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkoutVideo].
  Future<WorkoutVideo> deleteRow(
    _i1.DatabaseSession session,
    WorkoutVideo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutVideo>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkoutVideo>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutVideoTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkoutVideo>(
      where: where(WorkoutVideo.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutVideoTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutVideo>(
      where: where?.call(WorkoutVideo.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutVideo] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutVideoTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutVideo>(
      where: where(WorkoutVideo.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
