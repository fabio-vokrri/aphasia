import 'package:aphasia/model/word.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/word_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Aphasia"),
      ),
      body: provider.isEmpty
          ? const Center(
              child: Text(
                "Nessuna parola ancora inserita!",
              ),
            )
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

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final _wordController = TextEditingController();

  @override
  void dispose() {
    _wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(32.0).add(
        EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aggiungi una nuova parola!",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 32.0),
          TextFormField(
            controller: _wordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Parola"),
            ),
          ),
          const SizedBox(height: 32.0),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () {
                if (_wordController.text.isNotEmpty) {
                  provider.add(Word(_wordController.text));
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text("Aggiungi alle parole"),
            ),
          )
        ],
      ),
    );
  }
}
