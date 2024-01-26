import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  static const String _usernameKey = "userName";
  static const String _isNewUserKey = "isNewUser";
  static const String _defaultUserName = "Utente";

  static late String _userName;
  static late bool _isNewUser;

  /// Initializes the user provider
  static Future<void> init() async {
    final preferences = await SharedPreferences.getInstance();
    _userName = preferences.getString(_usernameKey) ?? _defaultUserName;
    _isNewUser = preferences.getBool(_isNewUserKey) ?? true;
  }

  static Future<void> setUserName(String newUserName) async {
    _userName = newUserName;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_usernameKey, newUserName);
    await preferences.setBool(_isNewUserKey, false);
  }

  static String get getUserName => _userName;
  static bool get isNewUser => _isNewUser;
}
