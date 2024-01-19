import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final wordProvider = Provider.of<WordProvider>(context);
    final theme = Theme.of(context);

    return DrawerHeader(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(color: theme.primaryColor),
      child: FutureBuilder(
        future: userProvider.isInitCompleted,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: MediaQuery.of(context).size.width / 15,
                  backgroundImage: userProvider.user.image == null
                      ? null
                      : MemoryImage(userProvider.user.image!),
                  child: userProvider.user.image != null
                      ? null
                      : Text(userProvider.user.name.characters.first),
                ),
                const SizedBox(width: 16),
                Text.rich(
                  TextSpan(
                    text: "${userProvider.user.name}\n",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade,
                    ),
                    children: [
                      TextSpan(
                        text: wordProvider.getWordsCountString(),
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(0.5),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
