import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TTSProvider {
  static const _platform = MethodChannel("tts_service");

  static Future<void> speak(String word) async {
    try {
      _platform.invokeMethod("speak", word);
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }
}
