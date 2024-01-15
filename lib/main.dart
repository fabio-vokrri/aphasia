import 'package:aphasia/providers/tts_provider.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  runApp(const Aphasia());
}

class Aphasia extends StatelessWidget {
  const Aphasia({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WordProvider()),
        ChangeNotifierProvider(create: (context) => TTSProvider()),
      ],
      child: MaterialApp(
        title: "Aphasia",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}
