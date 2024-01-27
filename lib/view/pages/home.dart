import 'package:aphasia/constants.dart';
import 'package:aphasia/providers/edit_mode_provider.dart';
import 'package:aphasia/providers/page_provider.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/add_word_fab.dart';
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
  final _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context);
    final editModeProvider = Provider.of<EditModeProvider>(context);

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
      drawer: const CustomDrawer(),
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

          if (wordProvider.filterBy(_filter).isEmpty) {
            return const Center(child: Text("Nessuna parola ancora aggiunta!"));
          } else {
            return GridView.count(
              controller: _controller,
              crossAxisCount: UserProvider.getNumberOfCardsPerRow,
              padding: const EdgeInsets.all(kMediumSize),
              mainAxisSpacing: kSmallSize,
              crossAxisSpacing: kSmallSize,
              childAspectRatio: goldenRatio - 1,
              children: wordProvider.filterBy(_filter).map((word) {
                return WordCard(word: word);
              }).toList(),
            );
          }
        },
      ),
      floatingActionButtonLocation: UserProvider.getIsRightToLeft
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: const AddWordFAB(),
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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    final wordProvider = Provider.of<WordProvider>(context);
    final theme = Theme.of(context);

    return NavigationDrawer(
      selectedIndex: pageProvider.getIndex,
      onDestinationSelected: (int index) {
        if (pageProvider.getIndex != index) {
          pageProvider.setIndexTo(index);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => pageProvider.getPage),
          );
        }
      },
      tilePadding: const EdgeInsets.only(right: kMediumSize),
      indicatorShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(kMediumSize),
        ),
      ),
      children: [
        DrawerHeader(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                text: "${UserProvider.getUserName}\n",
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: wordProvider.getWordsCountString(),
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.75),
                    ),
                  )
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text("Pagina iniziale"),
        ),
        // const NavigationDrawerDestination(
        //   icon: Icon(Icons.calendar_month_outlined),
        //   selectedIcon: Icon(Icons.calendar_month),
        //   label: Text("Calendario"),
        // ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text("Impostazioni"),
        ),
      ],
    );
  }
}
