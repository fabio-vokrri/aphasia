import 'package:aphasia/view/components/custom_drawer_header.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDrawerHeader(),
        ],
      ),
    );
  }
}
