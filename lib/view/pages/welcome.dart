import 'package:aphasia/extensions/capitalize.dart';
import 'package:aphasia/model/user.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();

  final _pages = [
    const FirstWelcomePage(),
    const SecondWelcomePage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      extendBody: true,
      body: PageView(controller: _pageController, children: _pages),
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
          const Placeholder(color: Colors.white10),
          const SizedBox(height: 32.0),
          Text(
            "Benvenuto ad Aphasia",
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall!.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
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
  final _key = GlobalKey<FormState>();
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
    final userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
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
          const SizedBox(height: 16),
          Form(
            key: _key,
            child: TextFormField(
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
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.colorScheme.onPrimary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.colorScheme.onPrimary),
                ),
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
          ),
          const SizedBox(height: 32),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              backgroundColor: theme.primaryColor,
              foregroundColor: theme.colorScheme.onPrimary,
              elevation: 0,
              label: const Row(
                children: [
                  Text("Incominciamo"),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
              onPressed: () {
                if (!_key.currentState!.validate()) return;

                final newUser = User(
                  name: _nameController.text.capitalized,
                );
                userProvider.add(newUser);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
