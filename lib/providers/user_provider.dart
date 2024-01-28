import 'package:aphasia/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  static const String _defaultUserName = "Utente";

  static late String _userName;
  static late bool _isNewUser;

  static late final SharedPreferences _sharedPreferences;

  /// Initializes the user provider
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _userName = _sharedPreferences.getString(userNameKey) ?? _defaultUserName;
    _isNewUser = _sharedPreferences.getBool(isNewUserKey) ?? true;
  }

  static Future<void> setUserName(String newUserName) async {
    _userName = newUserName;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(userNameKey, newUserName);
    await preferences.setBool(isNewUserKey, false);
  }

  static String get getUserName => _userName;
  static bool get isNewUser => _isNewUser;
}
