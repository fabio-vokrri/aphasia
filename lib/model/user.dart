import 'dart:typed_data';

import 'package:uuid/uuid.dart';

class User {
  final String _name;
  final Uint8List? _image;
  final String? _id;

  User({
    required String name,
    String? id,
    Uint8List? image,
  })  : _name = name,
        _id = id ?? const Uuid().v8(),
        _image = image;

  String get name => _name;
  Uint8List? get image => _image;
  String get id => _id!;

  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "id": _id,
      "image": _image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map["name"],
      id: map["id"],
      image: map["image"],
    );
  }

  User copyWith({String? name, Uint8List? image}) {
    return User(
      name: name ?? _name,
      image: image ?? _image,
      id: _id!,
    );
  }
}
