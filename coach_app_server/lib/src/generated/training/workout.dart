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

abstract class Workout
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = WorkoutTable();

  static const db = WorkoutRepository._();

  @override
  int? id;

  int userId;

  String title;

  DateTime scheduledAt;

  int? durationMinutes;

  String? notes;

  bool isCompleted;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static WorkoutInclude include() {
    return WorkoutInclude._();
  }

  static WorkoutIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkoutTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutTable>? orderByList,
    WorkoutInclude? include,
  }) {
    return WorkoutIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Workout.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Workout.t),
      include: include,
    );
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

class WorkoutUpdateTable extends _i1.UpdateTable<WorkoutTable> {
  WorkoutUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> scheduledAt(DateTime value) =>
      _i1.ColumnValue(
        table.scheduledAt,
        value,
      );

  _i1.ColumnValue<int, int> durationMinutes(int? value) => _i1.ColumnValue(
    table.durationMinutes,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<bool, bool> isCompleted(bool value) => _i1.ColumnValue(
    table.isCompleted,
    value,
  );
}

class WorkoutTable extends _i1.Table<int?> {
  WorkoutTable({super.tableRelation}) : super(tableName: 'workout') {
    updateTable = WorkoutUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    scheduledAt = _i1.ColumnDateTime(
      'scheduledAt',
      this,
    );
    durationMinutes = _i1.ColumnInt(
      'durationMinutes',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    isCompleted = _i1.ColumnBool(
      'isCompleted',
      this,
    );
  }

  late final WorkoutUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString title;

  late final _i1.ColumnDateTime scheduledAt;

  late final _i1.ColumnInt durationMinutes;

  late final _i1.ColumnString notes;

  late final _i1.ColumnBool isCompleted;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    title,
    scheduledAt,
    durationMinutes,
    notes,
    isCompleted,
  ];
}

class WorkoutInclude extends _i1.IncludeObject {
  WorkoutInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Workout.t;
}

class WorkoutIncludeList extends _i1.IncludeList {
  WorkoutIncludeList._({
    _i1.WhereExpressionBuilder<WorkoutTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Workout.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Workout.t;
}

class WorkoutRepository {
  const WorkoutRepository._();

  /// Returns a list of [Workout]s matching the given query parameters.
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
  Future<List<Workout>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Workout>(
      where: where?.call(Workout.t),
      orderBy: orderBy?.call(Workout.t),
      orderByList: orderByList?.call(Workout.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Workout] matching the given query parameters.
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
  Future<Workout?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkoutTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Workout>(
      where: where?.call(Workout.t),
      orderBy: orderBy?.call(Workout.t),
      orderByList: orderByList?.call(Workout.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Workout] by its [id] or null if no such row exists.
  Future<Workout?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Workout>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Workout]s in the list and returns the inserted rows.
  ///
  /// The returned [Workout]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Workout>> insert(
    _i1.DatabaseSession session,
    List<Workout> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Workout>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Workout] and returns the inserted row.
  ///
  /// The returned [Workout] will have its `id` field set.
  Future<Workout> insertRow(
    _i1.DatabaseSession session,
    Workout row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Workout>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Workout]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Workout>> update(
    _i1.DatabaseSession session,
    List<Workout> rows, {
    _i1.ColumnSelections<WorkoutTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Workout>(
      rows,
      columns: columns?.call(Workout.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Workout]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Workout> updateRow(
    _i1.DatabaseSession session,
    Workout row, {
    _i1.ColumnSelections<WorkoutTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Workout>(
      row,
      columns: columns?.call(Workout.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Workout] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Workout?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkoutUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Workout>(
      id,
      columnValues: columnValues(Workout.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Workout]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Workout>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WorkoutUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WorkoutTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutTable>? orderBy,
    _i1.OrderByListBuilder<WorkoutTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Workout>(
      columnValues: columnValues(Workout.t.updateTable),
      where: where(Workout.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Workout.t),
      orderByList: orderByList?.call(Workout.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Workout]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Workout>> delete(
    _i1.DatabaseSession session,
    List<Workout> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Workout>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Workout].
  Future<Workout> deleteRow(
    _i1.DatabaseSession session,
    Workout row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Workout>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Workout>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Workout>(
      where: where(Workout.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Workout>(
      where: where?.call(Workout.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Workout] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Workout>(
      where: where(Workout.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
