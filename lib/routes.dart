import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/view/pages/home.dart';
import 'package:aphasia/view/pages/welcome.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();

  static final key = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        if (UserProvider.isNewUser) {
          return MaterialPageRoute(builder: (context) => const WelcomePage());
        }

        return MaterialPageRoute(builder: (context) => const HomePage());

      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Qualcosa è andato storto :/"),
      ),
    );
  }
}
