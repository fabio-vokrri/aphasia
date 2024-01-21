import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  static const String _key = "userName";
  static String? _userName;

  static Future<void> init() async {
    final preferences = await SharedPreferences.getInstance();
    _userName = preferences.getString(_key);
  }

  static Future<void> setUserName(String newUserName) async {
    _userName = newUserName;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_key, newUserName);
  }

  static bool get isNewUser => getUserName == null;
  static String? get getUserName => _userName;
}
