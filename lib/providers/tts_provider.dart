import 'package:aphasia/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSProvider {
  static final _service = FlutterTts()..setLanguage("it");

  static speak(String word) async {
    await _service.speak(word);
  }

  static setPitchTo(double value) async {
    await _service.setPitch(value);
  }

  static setVolumeTo(double value) async {
    await _service.setVolume(value);
  }

  static setSpeedTo(double value) async {
    await _service.setSpeechRate(value);
  }

  static void reset() async {
    await _service.setSpeechRate(kSpeed);
    await _service.setVolume(kVolume);
    await _service.setPitch(kPitch);
  }
}
