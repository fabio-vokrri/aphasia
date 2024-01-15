import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSProvider extends ChangeNotifier {
  final _tts = FlutterTts();

  TTSProvider() {
    _ttsInit();
  }

  Future<void> _ttsInit() async {
    await _tts.setVolume(1);
    await _tts.setLanguage("it");
  }

  FlutterTts get getTTSService => _tts;
}
