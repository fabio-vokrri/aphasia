import 'package:aphasia/constants.dart';
import 'package:aphasia/providers/tts_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider {
  static late bool _isRightToLeft;
  static late bool _removeAnimations;
  static late double _volumeValue;
  static late double _speedValue;
  static late double _pitchValue;
  static late int _cardsPerRow;

  static late final SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _isRightToLeft = _sharedPreferences.getBool(isRTLKey) ?? kIsRTL;
    _removeAnimations =
        _sharedPreferences.getBool(removeAnimationsKey) ?? kRemoveAnimations;
    _volumeValue = _sharedPreferences.getDouble(volumeKey) ?? kVolume;
    _speedValue = _sharedPreferences.getDouble(speedKey) ?? kSpeed;
    _pitchValue = _sharedPreferences.getDouble(pitchKey) ?? kPitch;
    _cardsPerRow = _sharedPreferences.getInt(cardsPerRowKey) ?? kCardsPerRow;
  }

  static bool get getIsRightToLeft => _isRightToLeft;
  static bool get getAnimationsAreRemoved => _removeAnimations;
  static double get getVolume => _volumeValue;
  static double get getSpeed => _speedValue;
  static double get getPitch => _pitchValue;
  static int get getNumberOfCardsPerRow => _cardsPerRow;

  static void toggleRTL() async {
    _isRightToLeft = !_isRightToLeft;
    await _sharedPreferences.setBool(isRTLKey, _isRightToLeft);
  }

  static void toggleAnimations() async {
    _removeAnimations = !_removeAnimations;
    await _sharedPreferences.setBool(removeAnimationsKey, _removeAnimations);
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
