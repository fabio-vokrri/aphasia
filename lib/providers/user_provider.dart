import 'package:aphasia/db/user_db.dart';
import 'package:aphasia/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final UserDatabaseService _dataBaseService;

  User? _user;

  UserProvider() : _dataBaseService = UserDatabaseService() {
    init();
  }

  Future<void> init() async {
    _user ??= await _dataBaseService.getUser;
  }

  Future<void> add(User user) async {
    // if (_user != null) return;

    await _dataBaseService.add(user);
    notifyListeners();
  }

  Future<void> updateName(String name) async {
    if (_user == null) {}
    _user = _user!.copyWith(name: name);
    await _update();
  }

  Future<void> _update() async {
    await _dataBaseService.update(_user!);
    notifyListeners();
  }

  User? get user => _user;
}
