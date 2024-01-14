import 'package:flutter/material.dart';

class AlreadyAddedDialog extends StatelessWidget {
  const AlreadyAddedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.warning_rounded),
      title: const Text("Attenzione!"),
      content: const Text(
        "Questa parola è già stata agginuta alla tua lista!",
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        )
      ],
    );
  }
}
