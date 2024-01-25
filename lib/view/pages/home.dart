import 'package:aphasia/constants.dart';
import 'package:aphasia/db/words_db.dart';
import 'package:aphasia/providers/edit_mode_provider.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/add_word_bottom_sheet.dart';
import 'package:aphasia/view/components/delete_words_dialog.dart';
import 'package:aphasia/view/components/no_selected_words_dialog.dart';
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
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editModeProvider.isEditMode
              ? "Modalità Modifica"
              : "Ciao ${UserProvider.getUserName}!",
        ),
        actions: [
          IconButton(
            onPressed: editModeProvider.toggleEditMode,
            icon: editModeProvider.isEditMode
                ? const Icon(Icons.close)
                : const Icon(Icons.edit),
            tooltip: "Modifica",
          ),
          const SizedBox(width: kMediumSize),
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
                  SizedBox(height: kMediumSize),
                  Text("Sto caricando le tue parole...")
                ],
              ),
            );
          }

          return wordProvider.filter(_filter).isEmpty
              ? const Center(child: Text("Nessuna parola ancora aggiunta!"))
              : GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(kMediumSize),
                  mainAxisSpacing: kSmallSize,
                  crossAxisSpacing: kSmallSize,
                  childAspectRatio: goldenRatio - 1,
                  children: wordProvider.filter(_filter).map((word) {
                    return WordCard(word: word);
                  }).toList(),
                );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(editModeProvider.isEditMode ? "Elimina " : "Aggiungi"),
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
        icon: Icon(editModeProvider.isEditMode ? Icons.delete : Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
            _filter = WordFilter.values[_currentIndex];
          });
        },
        destinations: [
          SizedBox(width: deviceWidth / 2),
          ...WordFilter.values.where((WordFilter filter) {
            return filter.toBeShown;
          }).map((filter) {
            return NavigationDestination(
              icon: filter.icon,
              label: filter.label,
              selectedIcon: filter.activeIcon,
            );
          }),
          SizedBox(width: deviceWidth / 2),
        ],
      ),
    );
  }
}
