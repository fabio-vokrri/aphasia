import 'package:aphasia/db/user_db.dart';
import 'package:aphasia/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  Future? isInitCompleted;
  final UserDatabaseService _dataBaseService;

  late User _user;

  UserProvider() : _dataBaseService = UserDatabaseService() {
    isInitCompleted = init();
  }

  Future<void> init() async {
    _user = await _dataBaseService.getUser;
  }

  Future<void> updateName(String name) async {
    _user = _user.copyWith(name: name);
    await _update();
  }

  Future<void> _update() async {
    await _dataBaseService.update(_user);
    notifyListeners();
  }

  User get user => _user;
}
