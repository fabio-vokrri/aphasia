import 'package:aphasia/model/word.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordProvider>(context);
    return AlertDialog(
      title: const Text("Eliminare la parola?"),
      content: const Text(
        "Una volta eliminata, la parola non può più essere recuperata. Sicuro di voler procedere?",
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annulla"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            provider.delete(word);
            Navigator.pop(context);
          },
          child: const Text("Elimina"),
        ),
      ],
    );
  }
}
