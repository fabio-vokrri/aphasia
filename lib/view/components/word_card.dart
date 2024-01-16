import 'package:aphasia/model/word.dart';
import 'package:aphasia/providers/tts_provider.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/delete_dialog.dart';
import 'package:aphasia/view/components/word_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordCard extends StatelessWidget {
  const WordCard({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final tts = Provider.of<TTSProvider>(context).getTTSService;
    final provider = Provider.of<WordProvider>(context);

    return GestureDetector(
      onTap: () => tts.speak(word.getContent),
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => DeleteDialog(word: word),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            image: word.getImage != null
                ? DecorationImage(
                    image: MemoryImage(word.getImage!),
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
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => provider.toggleFavourite(word),
                  icon: Icon(
                    word.isFavourite ? Icons.favorite : Icons.favorite_border,
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
