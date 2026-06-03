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

abstract class CoachAthlete
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CoachAthleteTable();

  static const db = CoachAthleteRepository._();

  @override
  int? id;

  int coachId;

  int athleteId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CoachAthlete',
      if (id != null) 'id': id,
      'coachId': coachId,
      'athleteId': athleteId,
      'createdAt': createdAt.toJson(),
    };
  }

  static CoachAthleteInclude include() {
    return CoachAthleteInclude._();
  }

  static CoachAthleteIncludeList includeList({
    _i1.WhereExpressionBuilder<CoachAthleteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CoachAthleteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CoachAthleteTable>? orderByList,
    CoachAthleteInclude? include,
  }) {
    return CoachAthleteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CoachAthlete.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CoachAthlete.t),
      include: include,
    );
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

class CoachAthleteUpdateTable extends _i1.UpdateTable<CoachAthleteTable> {
  CoachAthleteUpdateTable(super.table);

  _i1.ColumnValue<int, int> coachId(int value) => _i1.ColumnValue(
    table.coachId,
    value,
  );

  _i1.ColumnValue<int, int> athleteId(int value) => _i1.ColumnValue(
    table.athleteId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CoachAthleteTable extends _i1.Table<int?> {
  CoachAthleteTable({super.tableRelation}) : super(tableName: 'coach_athlete') {
    updateTable = CoachAthleteUpdateTable(this);
    coachId = _i1.ColumnInt(
      'coachId',
      this,
    );
    athleteId = _i1.ColumnInt(
      'athleteId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CoachAthleteUpdateTable updateTable;

  late final _i1.ColumnInt coachId;

  late final _i1.ColumnInt athleteId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    coachId,
    athleteId,
    createdAt,
  ];
}

class CoachAthleteInclude extends _i1.IncludeObject {
  CoachAthleteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CoachAthlete.t;
}

class CoachAthleteIncludeList extends _i1.IncludeList {
  CoachAthleteIncludeList._({
    _i1.WhereExpressionBuilder<CoachAthleteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CoachAthlete.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CoachAthlete.t;
}

class CoachAthleteRepository {
  const CoachAthleteRepository._();

  /// Returns a list of [CoachAthlete]s matching the given query parameters.
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
  Future<List<CoachAthlete>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CoachAthleteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CoachAthleteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CoachAthleteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CoachAthlete>(
      where: where?.call(CoachAthlete.t),
      orderBy: orderBy?.call(CoachAthlete.t),
      orderByList: orderByList?.call(CoachAthlete.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CoachAthlete] matching the given query parameters.
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
  Future<CoachAthlete?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CoachAthleteTable>? where,
    int? offset,
    _i1.OrderByBuilder<CoachAthleteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CoachAthleteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CoachAthlete>(
      where: where?.call(CoachAthlete.t),
      orderBy: orderBy?.call(CoachAthlete.t),
      orderByList: orderByList?.call(CoachAthlete.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CoachAthlete] by its [id] or null if no such row exists.
  Future<CoachAthlete?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CoachAthlete>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CoachAthlete]s in the list and returns the inserted rows.
  ///
  /// The returned [CoachAthlete]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CoachAthlete>> insert(
    _i1.DatabaseSession session,
    List<CoachAthlete> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CoachAthlete>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CoachAthlete] and returns the inserted row.
  ///
  /// The returned [CoachAthlete] will have its `id` field set.
  Future<CoachAthlete> insertRow(
    _i1.DatabaseSession session,
    CoachAthlete row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CoachAthlete>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CoachAthlete]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CoachAthlete>> update(
    _i1.DatabaseSession session,
    List<CoachAthlete> rows, {
    _i1.ColumnSelections<CoachAthleteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CoachAthlete>(
      rows,
      columns: columns?.call(CoachAthlete.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CoachAthlete]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CoachAthlete> updateRow(
    _i1.DatabaseSession session,
    CoachAthlete row, {
    _i1.ColumnSelections<CoachAthleteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CoachAthlete>(
      row,
      columns: columns?.call(CoachAthlete.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CoachAthlete] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CoachAthlete?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CoachAthleteUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CoachAthlete>(
      id,
      columnValues: columnValues(CoachAthlete.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CoachAthlete]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CoachAthlete>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CoachAthleteUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CoachAthleteTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CoachAthleteTable>? orderBy,
    _i1.OrderByListBuilder<CoachAthleteTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CoachAthlete>(
      columnValues: columnValues(CoachAthlete.t.updateTable),
      where: where(CoachAthlete.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CoachAthlete.t),
      orderByList: orderByList?.call(CoachAthlete.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CoachAthlete]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CoachAthlete>> delete(
    _i1.DatabaseSession session,
    List<CoachAthlete> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CoachAthlete>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CoachAthlete].
  Future<CoachAthlete> deleteRow(
    _i1.DatabaseSession session,
    CoachAthlete row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CoachAthlete>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CoachAthlete>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CoachAthleteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CoachAthlete>(
      where: where(CoachAthlete.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CoachAthleteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CoachAthlete>(
      where: where?.call(CoachAthlete.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CoachAthlete] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CoachAthleteTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CoachAthlete>(
      where: where(CoachAthlete.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
