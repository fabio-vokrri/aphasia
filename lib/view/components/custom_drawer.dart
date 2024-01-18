import 'package:aphasia/view/components/change_profile_picture_dialog.dart';
import 'package:aphasia/view/components/change_username_dialog.dart';
import 'package:aphasia/view/components/custo_drawer.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDrawerHeader(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Modifica nome utente"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const ChangeUsernameDialog(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Modifica foto profilo"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const ChangeProfilePictureDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
