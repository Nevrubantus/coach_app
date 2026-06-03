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

abstract class WorkoutSet
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = WorkoutSetTable();

  static const db = WorkoutSetRepository._();

  @override
  int? id;

  int workoutExerciseId;

  int setIndex;

  double weight;

  int reps;

  String? notes;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static WorkoutSetInclude include() {
    return WorkoutSetInclude._();
  }

  static WorkoutSetIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkoutSetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutSetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutSetTable>? orderByList,
    WorkoutSetInclude? include,
  }) {
    return WorkoutSetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutSet.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkoutSet.t),
      include: include,
    );
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

class WorkoutSetUpdateTable extends _i1.UpdateTable<WorkoutSetTable> {
  WorkoutSetUpdateTable(super.table);

  _i1.ColumnValue<int, int> workoutExerciseId(int value) => _i1.ColumnValue(
    table.workoutExerciseId,
    value,
  );

  _i1.ColumnValue<int, int> setIndex(int value) => _i1.ColumnValue(
    table.setIndex,
    value,
  );

  _i1.ColumnValue<double, double> weight(double value) => _i1.ColumnValue(
    table.weight,
    value,
  );

  _i1.ColumnValue<int, int> reps(int value) => _i1.ColumnValue(
    table.reps,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class WorkoutSetTable extends _i1.Table<int?> {
  WorkoutSetTable({super.tableRelation}) : super(tableName: 'workout_set') {
    updateTable = WorkoutSetUpdateTable(this);
    workoutExerciseId = _i1.ColumnInt(
      'workoutExerciseId',
      this,
    );
    setIndex = _i1.ColumnInt(
      'setIndex',
      this,
    );
    weight = _i1.ColumnDouble(
      'weight',
      this,
    );
    reps = _i1.ColumnInt(
      'reps',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final WorkoutSetUpdateTable updateTable;

  late final _i1.ColumnInt workoutExerciseId;

  late final _i1.ColumnInt setIndex;

  late final _i1.ColumnDouble weight;

  late final _i1.ColumnInt reps;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    workoutExerciseId,
    setIndex,
    weight,
    reps,
    notes,
    createdAt,
  ];
}

class WorkoutSetInclude extends _i1.IncludeObject {
  WorkoutSetInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WorkoutSet.t;
}

class WorkoutSetIncludeList extends _i1.IncludeList {
  WorkoutSetIncludeList._({
    _i1.WhereExpressionBuilder<WorkoutSetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutSet.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WorkoutSet.t;
}

class WorkoutSetRepository {
  const WorkoutSetRepository._();

  /// Returns a list of [WorkoutSet]s matching the given query parameters.
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
  Future<List<WorkoutSet>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutSetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutSetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutSetTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutSet>(
      where: where?.call(WorkoutSet.t),
      orderBy: orderBy?.call(WorkoutSet.t),
      orderByList: orderByList?.call(WorkoutSet.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutSet] matching the given query parameters.
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
  Future<WorkoutSet?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutSetTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkoutSetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutSetTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutSet>(
      where: where?.call(WorkoutSet.t),
      orderBy: orderBy?.call(WorkoutSet.t),
      orderByList: orderByList?.call(WorkoutSet.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutSet] by its [id] or null if no such row exists.
  Future<WorkoutSet?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutSet>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutSet]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutSet]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WorkoutSet>> insert(
    _i1.DatabaseSession session,
    List<WorkoutSet> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WorkoutSet>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WorkoutSet] and returns the inserted row.
  ///
  /// The returned [WorkoutSet] will have its `id` field set.
  Future<WorkoutSet> insertRow(
    _i1.DatabaseSession session,
    WorkoutSet row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutSet>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutSet]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkoutSet>> update(
    _i1.DatabaseSession session,
    List<WorkoutSet> rows, {
    _i1.ColumnSelections<WorkoutSetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkoutSet>(
      rows,
      columns: columns?.call(WorkoutSet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutSet]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutSet> updateRow(
    _i1.DatabaseSession session,
    WorkoutSet row, {
    _i1.ColumnSelections<WorkoutSetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutSet>(
      row,
      columns: columns?.call(WorkoutSet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutSet] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutSet?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkoutSetUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutSet>(
      id,
      columnValues: columnValues(WorkoutSet.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutSet]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkoutSet>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WorkoutSetUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WorkoutSetTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutSetTable>? orderBy,
    _i1.OrderByListBuilder<WorkoutSetTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkoutSet>(
      columnValues: columnValues(WorkoutSet.t.updateTable),
      where: where(WorkoutSet.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutSet.t),
      orderByList: orderByList?.call(WorkoutSet.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkoutSet]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkoutSet>> delete(
    _i1.DatabaseSession session,
    List<WorkoutSet> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkoutSet>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkoutSet].
  Future<WorkoutSet> deleteRow(
    _i1.DatabaseSession session,
    WorkoutSet row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutSet>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkoutSet>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutSetTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkoutSet>(
      where: where(WorkoutSet.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutSetTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutSet>(
      where: where?.call(WorkoutSet.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutSet] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutSetTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutSet>(
      where: where(WorkoutSet.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
