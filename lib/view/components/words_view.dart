import 'package:aphasia/constants.dart';
import 'package:aphasia/model/word.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/word_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordsView extends StatelessWidget {
  const WordsView({super.key, required this.words});

  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context);
    return FutureBuilder(
      future: wordProvider.isInitCompleted,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: kMediumSize),
                Text("Sto caricando le tue parole...")
              ],
            ),
          );
        }

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
      },
    );
  }
}