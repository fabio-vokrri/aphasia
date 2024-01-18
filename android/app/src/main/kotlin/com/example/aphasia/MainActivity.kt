package com.example.aphasia

import android.speech.tts.TextToSpeech
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Locale

class MainActivity : FlutterActivity() {
    private val channel = "tts_service"
    private lateinit var tts: TextToSpeech

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, _ ->
            if (call.method == "init") init()
            if (call.method == "speak") speak(call.arguments as String)
        }
    }

    private fun speak(word: String) {
        tts.speak(word, TextToSpeech.QUEUE_FLUSH, null, null);
    }

    private fun init() {
        tts = TextToSpeech(this) {
            tts.setLanguage(Locale.ITALY)
        }
    }
}
