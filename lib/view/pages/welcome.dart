import 'package:aphasia/constants.dart';
import 'package:aphasia/extensions/capitalize.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/view/pages/home.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: PageView(
          controller: _pageController,
          children: [
            GestureDetector(
              onTap: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: kDuration),
                  curve: Curves.easeOutExpo,
                );
              },
              child: const FirstWelcomePage(),
            ),
            const SecondWelcomePage(),
          ],
        ),
      ),
    );
  }
}

class FirstWelcomePage extends StatelessWidget {
  const FirstWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: MediaQuery.of(context).size.width / 2,
            child: Image.asset(
              "assets/logo.png",
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: kMediumSize),
          Text(
            "Benvenuto ad Aphasia",
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall!.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: kSmallSize),
          Text(
            "L'app che ti permette di parlare",
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(0.75),
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class SecondWelcomePage extends StatefulWidget {
  const SecondWelcomePage({super.key});

  @override
  State<SecondWelcomePage> createState() => _SecondWelcomePageState();
}

class _SecondWelcomePageState extends State<SecondWelcomePage> {
  final _focusNode = FocusNode();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final formBorder = OutlineInputBorder(
      borderSide: BorderSide(color: theme.colorScheme.onPrimary),
    );

    return Padding(
      padding: const EdgeInsets.all(kLargeSize),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Prima di iniziare...",
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: kMediumSize),
          TextFormField(
            focusNode: _focusNode,
            controller: _nameController,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Inserisci il tuo nome";
              }

              return null;
            },
            maxLength: 15,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
            cursorColor: theme.colorScheme.onPrimary,
            decoration: InputDecoration(
              border: formBorder,
              enabledBorder: formBorder,
              focusedBorder: formBorder,
              counterStyle: theme.textTheme.labelMedium!.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
              focusColor: theme.colorScheme.onPrimary,
              prefixIconColor: theme.colorScheme.onPrimary,
              label: Text(
                "Inserisci il tuo nome",
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: kLargeSize),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              backgroundColor: theme.primaryColor,
              foregroundColor: theme.colorScheme.onPrimary,
              label: const Row(
                children: [
                  Text("Incominciamo"),
                  SizedBox(width: kSmallSize),
                  Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
              onPressed: () {
                if (_nameController.text.isEmpty) return;
                UserProvider.setUserName(_nameController.text.capitalized);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
