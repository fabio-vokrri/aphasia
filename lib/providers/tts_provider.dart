import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TTSProvider {
  static const _platform = MethodChannel("tts_service");

  static void init() {
    try {
      _platform.invokeMethod("init");
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  /// Speaks out loud the given `word`.
  static void speak(String word) {
    try {
      _platform.invokeMethod("speak", word);
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }
}
