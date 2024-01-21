import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TTSProvider {
  static const _platform = MethodChannel("tts_service");

  static Future<void> init() async {
    try {
      await _platform.invokeMethod("init");
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  /// Speaks out loud the given `word`.
  static Future<void> speak(String word) async {
    try {
      await _platform.invokeMethod("speak", word);
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }
}
