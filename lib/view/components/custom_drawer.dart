import 'package:aphasia/constants.dart';
import 'package:aphasia/providers/page_provider.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/providers/words_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        const NavigationDrawerDestination(
          icon: Icon(Icons.calendar_month_outlined),
          selectedIcon: Icon(Icons.calendar_month),
          label: Text("Calendario"),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text("Impostazioni"),
        ),
      ],
    );
  }
}
