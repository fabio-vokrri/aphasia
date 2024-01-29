import 'package:aphasia/providers/edit_mode_provider.dart';
import 'package:aphasia/providers/events_provider.dart';
import 'package:aphasia/providers/page_provider.dart';
import 'package:aphasia/providers/settings_provider.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/providers/words_provider.dart';
import 'package:aphasia/view/pages/home.dart';
import 'package:aphasia/view/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // sets all the native UI overlays
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // initializes the user and settings providers.
  // Retrieves the user's locally saved data
  await UserProvider.init();
  await SettingsProvider.init();

  // sets high refresh rate for the devices that support it
  await FlutterDisplayMode.setHighRefreshRate();

  // runs the app
  runApp(Aphasia(isNewUser: UserProvider.isNewUser));
}

class Aphasia extends StatelessWidget {
  const Aphasia({super.key, required this.isNewUser});
  final bool isNewUser;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WordProvider()),
        ChangeNotifierProvider(create: (context) => EditModeProvider()),
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => EventsProvider()),
      ],
      // consumes the edit mode provider
      // in order to set the seed color to red when in edit mode.
      child: Consumer<EditModeProvider>(
        builder: (
          BuildContext context,
          EditModeProvider editModeProvider,
          Widget? child,
        ) {
          return MaterialApp(
            title: "Aphasia",
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale("it")],
            locale: const Locale.fromSubtags(languageCode: "it"),
            theme: ThemeData(colorSchemeSeed: editModeProvider.getColor),
            home: isNewUser ? const WelcomePage() : const HomePage(),
          );
        },
      ),
    );
  }
}
