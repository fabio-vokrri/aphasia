import 'package:aphasia/providers/settings_provider.dart';
import 'package:flutter/material.dart';

class ResetDialog extends StatelessWidget {
  const ResetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.refresh_rounded),
      title: const Text("Ripristinare le impostazioni?"),
      content: const Text(
        "Questo farà si che le impostazioni vengano ripristinate ai valori predefiniti.\n\n "
        "Sicuro di voler procedere?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annulla"),
        ),
        TextButton(
          onPressed: () {
            SettingsProvider.reset();
            Navigator.pop(context, true);
          },
          child: const Text("Conferma"),
        ),
      ],
    );
  }
}
