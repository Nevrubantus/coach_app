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

abstract class WorkoutExercise
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WorkoutExercise._({
    this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.exerciseName,
    required this.orderIndex,
    this.notes,
  });

  factory WorkoutExercise({
    int? id,
    required int workoutId,
    required int exerciseId,
    required String exerciseName,
    required int orderIndex,
    String? notes,
  }) = _WorkoutExerciseImpl;

  factory WorkoutExercise.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkoutExercise(
      id: jsonSerialization['id'] as int?,
      workoutId: jsonSerialization['workoutId'] as int,
      exerciseId: jsonSerialization['exerciseId'] as int,
      exerciseName: jsonSerialization['exerciseName'] as String,
      orderIndex: jsonSerialization['orderIndex'] as int,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = WorkoutExerciseTable();

  static const db = WorkoutExerciseRepository._();

  @override
  int? id;

  int workoutId;

  int exerciseId;

  String exerciseName;

  int orderIndex;

  String? notes;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkoutExercise]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkoutExercise copyWith({
    int? id,
    int? workoutId,
    int? exerciseId,
    String? exerciseName,
    int? orderIndex,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkoutExercise',
      if (id != null) 'id': id,
      'workoutId': workoutId,
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'orderIndex': orderIndex,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkoutExercise',
      if (id != null) 'id': id,
      'workoutId': workoutId,
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'orderIndex': orderIndex,
      if (notes != null) 'notes': notes,
    };
  }

  static WorkoutExerciseInclude include() {
    return WorkoutExerciseInclude._();
  }

  static WorkoutExerciseIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkoutExerciseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutExerciseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutExerciseTable>? orderByList,
    WorkoutExerciseInclude? include,
  }) {
    return WorkoutExerciseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutExercise.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkoutExercise.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkoutExerciseImpl extends WorkoutExercise {
  _WorkoutExerciseImpl({
    int? id,
    required int workoutId,
    required int exerciseId,
    required String exerciseName,
    required int orderIndex,
    String? notes,
  }) : super._(
         id: id,
         workoutId: workoutId,
         exerciseId: exerciseId,
         exerciseName: exerciseName,
         orderIndex: orderIndex,
         notes: notes,
       );

  /// Returns a shallow copy of this [WorkoutExercise]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkoutExercise copyWith({
    Object? id = _Undefined,
    int? workoutId,
    int? exerciseId,
    String? exerciseName,
    int? orderIndex,
    Object? notes = _Undefined,
  }) {
    return WorkoutExercise(
      id: id is int? ? id : this.id,
      workoutId: workoutId ?? this.workoutId,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      orderIndex: orderIndex ?? this.orderIndex,
      notes: notes is String? ? notes : this.notes,
    );
  }
}

class WorkoutExerciseUpdateTable extends _i1.UpdateTable<WorkoutExerciseTable> {
  WorkoutExerciseUpdateTable(super.table);

  _i1.ColumnValue<int, int> workoutId(int value) => _i1.ColumnValue(
    table.workoutId,
    value,
  );

  _i1.ColumnValue<int, int> exerciseId(int value) => _i1.ColumnValue(
    table.exerciseId,
    value,
  );

  _i1.ColumnValue<String, String> exerciseName(String value) => _i1.ColumnValue(
    table.exerciseName,
    value,
  );

  _i1.ColumnValue<int, int> orderIndex(int value) => _i1.ColumnValue(
    table.orderIndex,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );
}

class WorkoutExerciseTable extends _i1.Table<int?> {
  WorkoutExerciseTable({super.tableRelation})
    : super(tableName: 'workout_exercise') {
    updateTable = WorkoutExerciseUpdateTable(this);
    workoutId = _i1.ColumnInt(
      'workoutId',
      this,
    );
    exerciseId = _i1.ColumnInt(
      'exerciseId',
      this,
    );
    exerciseName = _i1.ColumnString(
      'exerciseName',
      this,
    );
    orderIndex = _i1.ColumnInt(
      'orderIndex',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
  }

  late final WorkoutExerciseUpdateTable updateTable;

  late final _i1.ColumnInt workoutId;

  late final _i1.ColumnInt exerciseId;

  late final _i1.ColumnString exerciseName;

  late final _i1.ColumnInt orderIndex;

  late final _i1.ColumnString notes;

  @override
  List<_i1.Column> get columns => [
    id,
    workoutId,
    exerciseId,
    exerciseName,
    orderIndex,
    notes,
  ];
}

class WorkoutExerciseInclude extends _i1.IncludeObject {
  WorkoutExerciseInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WorkoutExercise.t;
}

class WorkoutExerciseIncludeList extends _i1.IncludeList {
  WorkoutExerciseIncludeList._({
    _i1.WhereExpressionBuilder<WorkoutExerciseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkoutExercise.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WorkoutExercise.t;
}

class WorkoutExerciseRepository {
  const WorkoutExerciseRepository._();

  /// Returns a list of [WorkoutExercise]s matching the given query parameters.
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
  Future<List<WorkoutExercise>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutExerciseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutExerciseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutExerciseTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkoutExercise>(
      where: where?.call(WorkoutExercise.t),
      orderBy: orderBy?.call(WorkoutExercise.t),
      orderByList: orderByList?.call(WorkoutExercise.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkoutExercise] matching the given query parameters.
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
  Future<WorkoutExercise?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutExerciseTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkoutExerciseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkoutExerciseTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkoutExercise>(
      where: where?.call(WorkoutExercise.t),
      orderBy: orderBy?.call(WorkoutExercise.t),
      orderByList: orderByList?.call(WorkoutExercise.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkoutExercise] by its [id] or null if no such row exists.
  Future<WorkoutExercise?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkoutExercise>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkoutExercise]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkoutExercise]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WorkoutExercise>> insert(
    _i1.DatabaseSession session,
    List<WorkoutExercise> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WorkoutExercise>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WorkoutExercise] and returns the inserted row.
  ///
  /// The returned [WorkoutExercise] will have its `id` field set.
  Future<WorkoutExercise> insertRow(
    _i1.DatabaseSession session,
    WorkoutExercise row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkoutExercise>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutExercise]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkoutExercise>> update(
    _i1.DatabaseSession session,
    List<WorkoutExercise> rows, {
    _i1.ColumnSelections<WorkoutExerciseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkoutExercise>(
      rows,
      columns: columns?.call(WorkoutExercise.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutExercise]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkoutExercise> updateRow(
    _i1.DatabaseSession session,
    WorkoutExercise row, {
    _i1.ColumnSelections<WorkoutExerciseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkoutExercise>(
      row,
      columns: columns?.call(WorkoutExercise.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkoutExercise] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkoutExercise?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkoutExerciseUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkoutExercise>(
      id,
      columnValues: columnValues(WorkoutExercise.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkoutExercise]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkoutExercise>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WorkoutExerciseUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<WorkoutExerciseTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkoutExerciseTable>? orderBy,
    _i1.OrderByListBuilder<WorkoutExerciseTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkoutExercise>(
      columnValues: columnValues(WorkoutExercise.t.updateTable),
      where: where(WorkoutExercise.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkoutExercise.t),
      orderByList: orderByList?.call(WorkoutExercise.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkoutExercise]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkoutExercise>> delete(
    _i1.DatabaseSession session,
    List<WorkoutExercise> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkoutExercise>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkoutExercise].
  Future<WorkoutExercise> deleteRow(
    _i1.DatabaseSession session,
    WorkoutExercise row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkoutExercise>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkoutExercise>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutExerciseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkoutExercise>(
      where: where(WorkoutExercise.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkoutExerciseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkoutExercise>(
      where: where?.call(WorkoutExercise.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkoutExercise] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkoutExerciseTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkoutExercise>(
      where: where(WorkoutExercise.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
