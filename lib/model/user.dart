import 'dart:typed_data';

import 'package:uuid/uuid.dart';

class User {
  final String _name;
  final String? _id;

  User({required String name, String? id})
      : _name = name,
        _id = id ?? const Uuid().v8();

  String get name => _name;
  String get id => _id!;

  Map<String, dynamic> toMap() {
    return {"name": _name, "id": _id};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(name: map["name"], id: map["id"]);
  }

  User copyWith({String? name, Uint8List? image}) {
    return User(name: name ?? _name, id: _id!);
  }
}
