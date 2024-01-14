import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/bottom_sheet.dart';
import 'package:aphasia/view/components/word_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Aphasia")),
      body: provider.isEmpty
          ? const Center(child: Text("Nessuna parola ancora inserita!"))
          : GridView.count(
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              crossAxisCount: 2,
              children: provider.getWords
                  .map((element) => WordCard(word: element))
                  .toList(),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          showModalBottomSheet(
            showDragHandle: true,
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            builder: (context) => const CustomBottomSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
