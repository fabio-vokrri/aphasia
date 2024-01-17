import 'package:aphasia/db/words_db.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/bottom_sheet.dart';
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
    DatabaseService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordProvider>(context);
    const double goldenRatio = 1.61803398875;

    return Scaffold(
      appBar: AppBar(title: const Text("Aphasia")),
      body: FutureBuilder(
        future: provider.isInitCompleted,
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

          return provider.filter(_filter).isEmpty
              ? const Center(child: Text("Nessuna parola ancora aggiunta!"))
              : GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16.0),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: goldenRatio - 1,
                  children: provider
                      .filter(_filter)
                      .map((word) => WordCard(word: word))
                      .toList(),
                );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            _filter = WordFilter.values[_currentIndex];
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Tutte",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Preferite",
          ),
        ],
      ),
    );
  }
}
