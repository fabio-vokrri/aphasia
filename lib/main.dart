import 'package:aphasia/providers/edit_mode_provider.dart';
import 'package:aphasia/providers/tts_provider.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  TTSProvider.init();

  runApp(const Aphasia());
}

class Aphasia extends StatelessWidget {
  const Aphasia({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WordProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => EditModeProvider()),
      ],
      child: Consumer<EditModeProvider>(
        builder: (BuildContext context, EditModeProvider value, Widget? child) {
          return MaterialApp(
            title: "Aphasia",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(colorSchemeSeed: value.getColor),
            home: const WelcomePage(),
          );
        },
      ),
    );
  }
}
