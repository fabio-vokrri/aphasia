import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const Aphasia());
}

class Aphasia extends StatelessWidget {
  const Aphasia({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WordProvider(),
      child: const MaterialApp(
        title: "Aphasia",
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
