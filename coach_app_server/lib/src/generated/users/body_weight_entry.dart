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

abstract class BodyWeightEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = BodyWeightEntryTable();

  static const db = BodyWeightEntryRepository._();

  @override
  int? id;

  int userId;

  double weight;

  DateTime measuredAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BodyWeightEntry',
      if (id != null) 'id': id,
      'userId': userId,
      'weight': weight,
      'measuredAt': measuredAt.toJson(),
    };
  }

  static BodyWeightEntryInclude include() {
    return BodyWeightEntryInclude._();
  }

  static BodyWeightEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<BodyWeightEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BodyWeightEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BodyWeightEntryTable>? orderByList,
    BodyWeightEntryInclude? include,
  }) {
    return BodyWeightEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BodyWeightEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BodyWeightEntry.t),
      include: include,
    );
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

class BodyWeightEntryUpdateTable extends _i1.UpdateTable<BodyWeightEntryTable> {
  BodyWeightEntryUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<double, double> weight(double value) => _i1.ColumnValue(
    table.weight,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> measuredAt(DateTime value) =>
      _i1.ColumnValue(
        table.measuredAt,
        value,
      );
}

class BodyWeightEntryTable extends _i1.Table<int?> {
  BodyWeightEntryTable({super.tableRelation})
    : super(tableName: 'body_weight_entry') {
    updateTable = BodyWeightEntryUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    weight = _i1.ColumnDouble(
      'weight',
      this,
    );
    measuredAt = _i1.ColumnDateTime(
      'measuredAt',
      this,
    );
  }

  late final BodyWeightEntryUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDouble weight;

  late final _i1.ColumnDateTime measuredAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    weight,
    measuredAt,
  ];
}

class BodyWeightEntryInclude extends _i1.IncludeObject {
  BodyWeightEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BodyWeightEntry.t;
}

class BodyWeightEntryIncludeList extends _i1.IncludeList {
  BodyWeightEntryIncludeList._({
    _i1.WhereExpressionBuilder<BodyWeightEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BodyWeightEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BodyWeightEntry.t;
}

class BodyWeightEntryRepository {
  const BodyWeightEntryRepository._();

  /// Returns a list of [BodyWeightEntry]s matching the given query parameters.
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
  Future<List<BodyWeightEntry>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BodyWeightEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BodyWeightEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BodyWeightEntryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BodyWeightEntry>(
      where: where?.call(BodyWeightEntry.t),
      orderBy: orderBy?.call(BodyWeightEntry.t),
      orderByList: orderByList?.call(BodyWeightEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BodyWeightEntry] matching the given query parameters.
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
  Future<BodyWeightEntry?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BodyWeightEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<BodyWeightEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BodyWeightEntryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BodyWeightEntry>(
      where: where?.call(BodyWeightEntry.t),
      orderBy: orderBy?.call(BodyWeightEntry.t),
      orderByList: orderByList?.call(BodyWeightEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BodyWeightEntry] by its [id] or null if no such row exists.
  Future<BodyWeightEntry?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BodyWeightEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BodyWeightEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [BodyWeightEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BodyWeightEntry>> insert(
    _i1.DatabaseSession session,
    List<BodyWeightEntry> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BodyWeightEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BodyWeightEntry] and returns the inserted row.
  ///
  /// The returned [BodyWeightEntry] will have its `id` field set.
  Future<BodyWeightEntry> insertRow(
    _i1.DatabaseSession session,
    BodyWeightEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BodyWeightEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BodyWeightEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BodyWeightEntry>> update(
    _i1.DatabaseSession session,
    List<BodyWeightEntry> rows, {
    _i1.ColumnSelections<BodyWeightEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BodyWeightEntry>(
      rows,
      columns: columns?.call(BodyWeightEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BodyWeightEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BodyWeightEntry> updateRow(
    _i1.DatabaseSession session,
    BodyWeightEntry row, {
    _i1.ColumnSelections<BodyWeightEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BodyWeightEntry>(
      row,
      columns: columns?.call(BodyWeightEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BodyWeightEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BodyWeightEntry?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BodyWeightEntryUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BodyWeightEntry>(
      id,
      columnValues: columnValues(BodyWeightEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BodyWeightEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BodyWeightEntry>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BodyWeightEntryUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<BodyWeightEntryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BodyWeightEntryTable>? orderBy,
    _i1.OrderByListBuilder<BodyWeightEntryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BodyWeightEntry>(
      columnValues: columnValues(BodyWeightEntry.t.updateTable),
      where: where(BodyWeightEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BodyWeightEntry.t),
      orderByList: orderByList?.call(BodyWeightEntry.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BodyWeightEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BodyWeightEntry>> delete(
    _i1.DatabaseSession session,
    List<BodyWeightEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BodyWeightEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BodyWeightEntry].
  Future<BodyWeightEntry> deleteRow(
    _i1.DatabaseSession session,
    BodyWeightEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BodyWeightEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BodyWeightEntry>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BodyWeightEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BodyWeightEntry>(
      where: where(BodyWeightEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BodyWeightEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BodyWeightEntry>(
      where: where?.call(BodyWeightEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BodyWeightEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BodyWeightEntryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BodyWeightEntry>(
      where: where(BodyWeightEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
