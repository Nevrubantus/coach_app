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

abstract class User implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
