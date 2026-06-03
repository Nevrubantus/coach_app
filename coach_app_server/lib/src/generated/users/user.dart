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

abstract class User implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  User._({
    this.id,
    required this.name,
    required this.contact,
    required this.password,
    required this.isAthlete,
    this.height,
    this.weight,
    this.age,
    this.imagePath,
    this.imageScale,
    this.imageOffsetX,
    this.imageOffsetY,
  });

  factory User({
    int? id,
    required String name,
    required String contact,
    required String password,
    required bool isAthlete,
    String? height,
    String? weight,
    String? age,
    String? imagePath,
    double? imageScale,
    double? imageOffsetX,
    double? imageOffsetY,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      contact: jsonSerialization['contact'] as String,
      password: jsonSerialization['password'] as String,
      isAthlete: _i1.BoolJsonExtension.fromJson(jsonSerialization['isAthlete']),
      height: jsonSerialization['height'] as String?,
      weight: jsonSerialization['weight'] as String?,
      age: jsonSerialization['age'] as String?,
      imagePath: jsonSerialization['imagePath'] as String?,
      imageScale: (jsonSerialization['imageScale'] as num?)?.toDouble(),
      imageOffsetX: (jsonSerialization['imageOffsetX'] as num?)?.toDouble(),
      imageOffsetY: (jsonSerialization['imageOffsetY'] as num?)?.toDouble(),
    );
  }

  static final t = UserTable();

  static const db = UserRepository._();

  @override
  int? id;

  String name;

  String contact;

  String password;

  bool isAthlete;

  String? height;

  String? weight;

  String? age;

  String? imagePath;

  double? imageScale;

  double? imageOffsetX;

  double? imageOffsetY;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? name,
    String? contact,
    String? password,
    bool? isAthlete,
    String? height,
    String? weight,
    String? age,
    String? imagePath,
    double? imageScale,
    double? imageOffsetX,
    double? imageOffsetY,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      'name': name,
      'contact': contact,
      'password': password,
      'isAthlete': isAthlete,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (age != null) 'age': age,
      if (imagePath != null) 'imagePath': imagePath,
      if (imageScale != null) 'imageScale': imageScale,
      if (imageOffsetX != null) 'imageOffsetX': imageOffsetX,
      if (imageOffsetY != null) 'imageOffsetY': imageOffsetY,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      'name': name,
      'contact': contact,
      'password': password,
      'isAthlete': isAthlete,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (age != null) 'age': age,
      if (imagePath != null) 'imagePath': imagePath,
      if (imageScale != null) 'imageScale': imageScale,
      if (imageOffsetX != null) 'imageOffsetX': imageOffsetX,
      if (imageOffsetY != null) 'imageOffsetY': imageOffsetY,
    };
  }

  static UserInclude include() {
    return UserInclude._();
  }

  static UserIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(User.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String name,
    required String contact,
    required String password,
    required bool isAthlete,
    String? height,
    String? weight,
    String? age,
    String? imagePath,
    double? imageScale,
    double? imageOffsetX,
    double? imageOffsetY,
  }) : super._(
         id: id,
         name: name,
         contact: contact,
         password: password,
         isAthlete: isAthlete,
         height: height,
         weight: weight,
         age: age,
         imagePath: imagePath,
         imageScale: imageScale,
         imageOffsetX: imageOffsetX,
         imageOffsetY: imageOffsetY,
       );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? name,
    String? contact,
    String? password,
    bool? isAthlete,
    Object? height = _Undefined,
    Object? weight = _Undefined,
    Object? age = _Undefined,
    Object? imagePath = _Undefined,
    Object? imageScale = _Undefined,
    Object? imageOffsetX = _Undefined,
    Object? imageOffsetY = _Undefined,
  }) {
    return User(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      password: password ?? this.password,
      isAthlete: isAthlete ?? this.isAthlete,
      height: height is String? ? height : this.height,
      weight: weight is String? ? weight : this.weight,
      age: age is String? ? age : this.age,
      imagePath: imagePath is String? ? imagePath : this.imagePath,
      imageScale: imageScale is double? ? imageScale : this.imageScale,
      imageOffsetX: imageOffsetX is double? ? imageOffsetX : this.imageOffsetX,
      imageOffsetY: imageOffsetY is double? ? imageOffsetY : this.imageOffsetY,
    );
  }
}

class UserUpdateTable extends _i1.UpdateTable<UserTable> {
  UserUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> contact(String value) => _i1.ColumnValue(
    table.contact,
    value,
  );

  _i1.ColumnValue<String, String> password(String value) => _i1.ColumnValue(
    table.password,
    value,
  );

  _i1.ColumnValue<bool, bool> isAthlete(bool value) => _i1.ColumnValue(
    table.isAthlete,
    value,
  );

  _i1.ColumnValue<String, String> height(String? value) => _i1.ColumnValue(
    table.height,
    value,
  );

  _i1.ColumnValue<String, String> weight(String? value) => _i1.ColumnValue(
    table.weight,
    value,
  );

  _i1.ColumnValue<String, String> age(String? value) => _i1.ColumnValue(
    table.age,
    value,
  );

  _i1.ColumnValue<String, String> imagePath(String? value) => _i1.ColumnValue(
    table.imagePath,
    value,
  );

  _i1.ColumnValue<double, double> imageScale(double? value) => _i1.ColumnValue(
    table.imageScale,
    value,
  );

  _i1.ColumnValue<double, double> imageOffsetX(double? value) =>
      _i1.ColumnValue(
        table.imageOffsetX,
        value,
      );

  _i1.ColumnValue<double, double> imageOffsetY(double? value) =>
      _i1.ColumnValue(
        table.imageOffsetY,
        value,
      );
}

class UserTable extends _i1.Table<int?> {
  UserTable({super.tableRelation}) : super(tableName: 'app_user') {
    updateTable = UserUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    contact = _i1.ColumnString(
      'contact',
      this,
    );
    password = _i1.ColumnString(
      'password',
      this,
    );
    isAthlete = _i1.ColumnBool(
      'isAthlete',
      this,
    );
    height = _i1.ColumnString(
      'height',
      this,
    );
    weight = _i1.ColumnString(
      'weight',
      this,
    );
    age = _i1.ColumnString(
      'age',
      this,
    );
    imagePath = _i1.ColumnString(
      'imagePath',
      this,
    );
    imageScale = _i1.ColumnDouble(
      'imageScale',
      this,
    );
    imageOffsetX = _i1.ColumnDouble(
      'imageOffsetX',
      this,
    );
    imageOffsetY = _i1.ColumnDouble(
      'imageOffsetY',
      this,
    );
  }

  late final UserUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString contact;

  late final _i1.ColumnString password;

  late final _i1.ColumnBool isAthlete;

  late final _i1.ColumnString height;

  late final _i1.ColumnString weight;

  late final _i1.ColumnString age;

  late final _i1.ColumnString imagePath;

  late final _i1.ColumnDouble imageScale;

  late final _i1.ColumnDouble imageOffsetX;

  late final _i1.ColumnDouble imageOffsetY;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    contact,
    password,
    isAthlete,
    height,
    weight,
    age,
    imagePath,
    imageScale,
    imageOffsetX,
    imageOffsetY,
  ];
}

class UserInclude extends _i1.IncludeObject {
  UserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserIncludeList extends _i1.IncludeList {
  UserIncludeList._({
    _i1.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserRepository {
  const UserRepository._();

  /// Returns a list of [User]s matching the given query parameters.
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
  Future<List<User>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [User] matching the given query parameters.
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
  Future<User?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [User] by its [id] or null if no such row exists.
  Future<User?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<User>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [User]s in the list and returns the inserted rows.
  ///
  /// The returned [User]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<User>> insert(
    _i1.DatabaseSession session,
    List<User> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<User>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [User] and returns the inserted row.
  ///
  /// The returned [User] will have its `id` field set.
  Future<User> insertRow(
    _i1.DatabaseSession session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [User]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<User>> update(
    _i1.DatabaseSession session,
    List<User> rows, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<User> updateRow(
    _i1.DatabaseSession session,
    User row, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<User?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<User>(
      id,
      columnValues: columnValues(User.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [User]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<User>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<User>(
      columnValues: columnValues(User.t.updateTable),
      where: where(User.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [User]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<User>> delete(
    _i1.DatabaseSession session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [User].
  Future<User> deleteRow(
    _i1.DatabaseSession session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<User>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [User] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<User>(
      where: where(User.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
