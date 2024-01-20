import 'package:aphasia/db/words_db.dart';
import 'package:aphasia/providers/edit_mode_provider.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/add_word_bottom_sheet.dart';
import 'package:aphasia/view/components/custom_drawer.dart';
import 'package:aphasia/view/components/delete_dialog.dart';
import 'package:aphasia/view/components/word_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  WordFilter _filter = WordFilter.all;

  @override
  void dispose() {
    WordsDatabaseService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context);
    final editModeProvider = Provider.of<EditModeProvider>(context);
    final theme = Theme.of(context);

    const double goldenRatio = 1.61803398875;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editModeProvider.isEditMode ? "Modalità modifica" : "Aphasia",
        ),
        actions: [
          IconButton(
            onPressed: editModeProvider.toggleEditMode,
            icon: editModeProvider.isEditMode
                ? const Icon(Icons.close)
                : const Icon(Icons.edit),
            tooltip: "Modifica",
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      body: FutureBuilder(
        future: wordProvider.isInitCompleted,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Sto caricando le tue parole...")
                ],
              ),
            );
          }

          return wordProvider.filter(_filter).isEmpty
              ? const Center(child: Text("Nessuna parola ancora aggiunta!"))
              : GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16.0),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: goldenRatio - 1,
                  children: wordProvider.filter(_filter).map((word) {
                    return WordCard(word: word);
                  }).toList(),
                );
        },
      ),
      drawer: const CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: editModeProvider.isEditMode
            ? "Rimuovi selezionati"
            : "Aggiungi nuova parola",
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
        onPressed: () {
          if (editModeProvider.isEditMode) {
            showDialog(
              context: context,
              builder: (context) {
                if (wordProvider.filter(WordFilter.toBeDeleted).isEmpty) {
                  return AlertDialog(
                    icon: const Icon(Icons.warning),
                    title: const Text("Nessuna parola selezionata"),
                    content: const Text(
                      "Prima di procedere, seleziona le parole da eliminare",
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  );
                }
                return const DeleteDialog();
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
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          editModeProvider.exitEditMode();

          setState(() {
            _currentIndex = index;
            _filter = WordFilter.values[_currentIndex];
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Tutte"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Preferite"),
        ],
      ),
    );
  }
}
