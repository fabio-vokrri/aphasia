import 'package:flutter/material.dart';

class NoSelectedWordsDialog extends StatelessWidget {
  const NoSelectedWordsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.warning),
      title: const Text("Nessuna parola ancora selezionata"),
      content: const Text(
        "Prima di procedere, seleziona le parole che vorresti eliminare.",
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    );
  }
}
