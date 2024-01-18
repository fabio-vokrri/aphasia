import 'package:aphasia/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeUsernameDialog extends StatefulWidget {
  const ChangeUsernameDialog({super.key});

  @override
  State<ChangeUsernameDialog> createState() => _ChangeUsernameDialogState();
}

class _ChangeUsernameDialogState extends State<ChangeUsernameDialog> {
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProvider = Provider.of<UserProvider>(context);

    return AlertDialog(
      icon: const Icon(Icons.person),
      title: const Text("Modifica nome utente"),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          maxLength: 20,
          controller: _usernameController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: const Text("Nome"),
            suffixIcon: IconButton(
              tooltip: "Cancella nome",
              onPressed: _usernameController.clear,
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annulla"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: theme.colorScheme.onPrimary,
          ),
          onPressed: () {
            if (_usernameController.text.isNotEmpty) {
              userProvider.updateName(_usernameController.text);
            }
            Navigator.pop(context);
          },
          child: const Text("Modifica"),
        ),
      ],
    );
  }
}
