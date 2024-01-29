import 'package:aphasia/constants.dart';
import 'package:aphasia/model/word.dart';
import 'package:aphasia/providers/edit_mode_provider.dart';
import 'package:aphasia/services/tts_service_provider.dart';
import 'package:aphasia/providers/words_provider.dart';
import 'package:aphasia/view/components/word_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordCard extends StatelessWidget {
  const WordCard({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context);
    final editModeProvider = Provider.of<EditModeProvider>(context);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        if (!editModeProvider.isEditMode) {
          TTSProvider.speak(word.content);
          wordProvider.incrementCounter(word);
        } else {
          wordProvider.toggleSelected(word);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kMediumSize),
        child: Container(
          decoration: BoxDecoration(
            color: theme.primaryColor,
            image: word.image != null
                ? DecorationImage(
                    image: MemoryImage(word.image!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    if (editModeProvider.isEditMode) {
                      wordProvider.toggleSelected(word);
                    } else {
                      wordProvider.toggleFavourite(word);
                    }
                  },
                  icon: editModeProvider.isEditMode
                      ? Icon(
                          word.isSelected ? Icons.delete : Icons.delete_outline,
                        )
                      : Icon(
                          word.isFavourite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: WordLabel(word: word),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
