import 'package:flutter_tts/flutter_tts.dart';

class TTSProvider {
  static final _service = FlutterTts()..setLanguage("it");

  static speak(String word) async {
    await _service.speak(word);
  }
}
