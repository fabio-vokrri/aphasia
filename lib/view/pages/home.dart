import 'package:aphasia/constants.dart';
import 'package:aphasia/providers/edit_mode_provider.dart';
import 'package:aphasia/providers/settings_provider.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/providers/words_provider.dart';
import 'package:aphasia/view/components/add_word_fab.dart';
import 'package:aphasia/view/components/custom_drawer.dart';
import 'package:aphasia/view/components/words_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  WordFilter _filter = WordFilter.all;
  final _controller = ScrollController();
  bool _showFAB = true;

  @override
  void initState() {
    if (!SettingsProvider.getAnimationsAreRemoved) {
      _controller.addListener(() {
        if (_controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          setState(() => _showFAB = false);
        } else {
          setState(() => _showFAB = true);
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wordsProvider = Provider.of<WordProvider>(context);
    final editModeProvider = Provider.of<EditModeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editModeProvider.isEditMode
              ? "Modalità Elimina"
              : "Ciao ${UserProvider.getUserName}!",
        ),
        actions: [
          IconButton(
            onPressed: editModeProvider.toggleEditMode,
            icon: editModeProvider.isEditMode
                ? const Icon(Icons.close)
                : const Icon(Icons.delete),
            tooltip: "Elimina parole",
          ),
          const SizedBox(width: kMediumSize),
        ],
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
        future: wordsProvider.isInitCompleted,
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

          return WordsList(words: wordsProvider.filterBy(_filter));
        },
      ),
      floatingActionButtonLocation: SettingsProvider.getIsRightToLeft
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: _showFAB ? const AddWordFAB() : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
            _filter = WordFilter.values[_currentIndex];
          });
        },
        destinations: [
          ...WordFilter.values.map((filter) {
            return NavigationDestination(
              tooltip: filter.label,
              icon: filter.icon,
              label: filter.label,
              selectedIcon: filter.activeIcon,
            );
          }),
        ],
      ),
    );
  }
}
