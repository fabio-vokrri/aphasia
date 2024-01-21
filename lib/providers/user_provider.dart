import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  static const String _key = "userName";
  static String? _userName;

  static Future<String?> get getUserName async {
    if (_userName != null) _userName;

    final preferences = await SharedPreferences.getInstance();
    _userName = preferences.getString(_key);
    return _userName;
  }

  static Future<void> setUserName(String newUserName) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_key, newUserName);
  }

  static Future<bool> get isNewUser async => await getUserName == null;
}
