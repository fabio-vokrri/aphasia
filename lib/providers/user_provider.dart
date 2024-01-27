import 'package:aphasia/constants.dart';
import 'package:aphasia/providers/tts_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  static const String _defaultUserName = "Utente";

  static late String _userName;
  static late bool _isNewUser;
  static late bool _isRightToLeft;
  static late double _volumeValue;
  static late double _speedValue;
  static late double _pitchValue;
  static late int _cardsPerRow;

  static late final SharedPreferences _sharedPreferences;

  /// Initializes the user provider
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _userName = _sharedPreferences.getString(userNameKey) ?? _defaultUserName;
    _isNewUser = _sharedPreferences.getBool(isNewUserKey) ?? true;

    _isRightToLeft = _sharedPreferences.getBool(isRTLKey) ?? kIsRTL;
    _volumeValue = _sharedPreferences.getDouble(volumeKey) ?? kVolume;
    _speedValue = _sharedPreferences.getDouble(speedKey) ?? kSpeed;
    _pitchValue = _sharedPreferences.getDouble(pitchKey) ?? kPitch;
    _cardsPerRow = _sharedPreferences.getInt(cardsPerRowKey) ?? kCardsPerRow;
  }

  static Future<void> setUserName(String newUserName) async {
    _userName = newUserName;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(userNameKey, newUserName);
    await preferences.setBool(isNewUserKey, false);
  }

  static String get getUserName => _userName;
  static bool get isNewUser => _isNewUser;
  static bool get getIsRightToLeft => _isRightToLeft;
  static double get getVolume => _volumeValue;
  static double get getSpeed => _speedValue;
  static double get getPitch => _pitchValue;
  static int get getNumberOfCardsPerRow => _cardsPerRow;

  static void toggleRTL() async {
    _isRightToLeft = !_isRightToLeft;
    await _sharedPreferences.setBool(isRTLKey, _isRightToLeft);
  }

  static void setVolumeTo(double value) async {
    _volumeValue = value;
    await _sharedPreferences.setDouble(volumeKey, _volumeValue);
    TTSProvider.setVolumeTo(value);
  }

  static void setSpeedTo(double value) async {
    _speedValue = value;
    await _sharedPreferences.setDouble(speedKey, _speedValue);
    TTSProvider.setSpeedTo(value);
  }

  static void setPitchTo(double value) async {
    _pitchValue = value;
    await _sharedPreferences.setDouble(pitchKey, _pitchValue);
    TTSProvider.setPitchTo(value);
  }

  static void setCardsPerRowTo(int value) async {
    _cardsPerRow = value;
    await _sharedPreferences.setInt(cardsPerRowKey, value);
  }

  static Future<void> reset() async {
    _cardsPerRow = kCardsPerRow;
    _isRightToLeft = kIsRTL;
    _pitchValue = kPitch;
    _speedValue = kSpeed;
    _volumeValue = kVolume;

    TTSProvider.reset();

    await _sharedPreferences.setBool(isRTLKey, kIsRTL);
    await _sharedPreferences.setDouble(volumeKey, kVolume);
    await _sharedPreferences.setDouble(speedKey, kSpeed);
    await _sharedPreferences.setDouble(pitchKey, kPitch);
  }
}
