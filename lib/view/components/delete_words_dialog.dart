import 'package:aphasia/providers/edit_mode_provider.dart';
import 'package:aphasia/providers/words_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteWordsDialog extends StatelessWidget {
  const DeleteWordsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context);
    final editModeProvider = Provider.of<EditModeProvider>(context);

    return AlertDialog(
      icon: const Icon(Icons.delete),
      title: const Text("Eliminare le parole selezionate?"),
      content: const Text(
        "Una volta eliminate, le parole non possono più essere recuperate.\n\n"
        "Sicuro di voler procedere?",
      ),
      actions: [
        TextButton(
          onPressed: () {
            editModeProvider.exitEditMode();
            Navigator.pop(context);
          },
          child: const Text("Annulla"),
        ),
        TextButton(
          onPressed: () {
            wordProvider.deleteBin();
            editModeProvider.exitEditMode();
            Navigator.pop(context);
          },
          child: const Text("Conferma"),
        ),
      ],
    );
  }
}
