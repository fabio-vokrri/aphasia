import 'package:aphasia/providers/edit_mode_provider.dart';
import 'package:aphasia/providers/words_provider.dart';
import 'package:aphasia/view/components/add_word_bottom_sheet.dart';
import 'package:aphasia/view/components/delete_words_dialog.dart';
import 'package:aphasia/view/components/no_selected_words_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddWordFAB extends StatelessWidget {
  const AddWordFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context);
    final editModeProvider = Provider.of<EditModeProvider>(context);

    return FloatingActionButton(
      tooltip: editModeProvider.isEditMode
          ? "Rimuovi selezionati"
          : "Aggiungi nuova parola",
      onPressed: () {
        if (editModeProvider.isEditMode) {
          showDialog(
            context: context,
            builder: (context) {
              if (wordProvider.getToBeDeletedWords.isEmpty) {
                return const NoSelectedWordsDialog();
              }
              return const DeleteWordsDialog();
            },
          );
        } else {
          showModalBottomSheet(
            showDragHandle: true,
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            builder: (context) => const AddWordBottomSheet(),
          );
        }
      },
      child: Icon(editModeProvider.isEditMode ? Icons.delete : Icons.add),
    );
  }
}
