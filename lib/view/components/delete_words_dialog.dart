import 'package:aphasia/providers/edit_mode_provider.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteWordsDialog extends StatelessWidget {
  const DeleteWordsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context);
    final editModeProvider = Provider.of<EditModeProvider>(context);
    final theme = Theme.of(context);

    return AlertDialog(
      icon: const Icon(Icons.delete),
      title: const Text("Eliminare le parole selezionate?"),
      content: const Text(
        "Una volta eliminate, le parole non possono più essere recuperate. Sicuro di voler procedere?",
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            editModeProvider.exitEditMode();
            Navigator.pop(context);
          },
          child: const Text("Annulla"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
          ),
          onPressed: () {
            wordProvider.deleteBin();
            editModeProvider.exitEditMode();
            Navigator.pop(context);
          },
          child: const Text("Elimina"),
        ),
      ],
    );
  }
}
