import 'package:aphasia/constants.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Impostazioni")),
      // drawer: const CustomDrawer(),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Impostazioni Utente",
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(width: kMediumSize),
              const Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
