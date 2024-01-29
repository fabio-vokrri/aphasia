import 'package:aphasia/constants.dart';
import 'package:aphasia/model/word.dart';
import 'package:aphasia/view/components/word_card.dart';
import 'package:flutter/material.dart';

class WordsList extends StatelessWidget {
  const WordsList({super.key, required this.words});

  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    return words.isEmpty
        ? const Center(child: Text("Nessuna parola ancora aggiunta!"))
        : GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(kMediumSize),
            mainAxisSpacing: kSmallSize,
            crossAxisSpacing: kSmallSize,
            childAspectRatio: goldenRatio - 1,
            children: words.map((word) {
              return WordCard(word: word);
            }).toList(),
          );
  }
}
