import 'package:aphasia/model/word.dart';
import 'package:flutter/material.dart';

class WordLabel extends StatelessWidget {
  const WordLabel({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: theme.primaryColor),
      child: Text(
        word.content,
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
          fontSize: 18,
        ),
        overflow: TextOverflow.fade,
      ),
    );
  }
}
