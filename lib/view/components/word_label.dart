import 'package:aphasia/model/word.dart';
import 'package:flutter/material.dart';

class WordLabel extends StatelessWidget {
  const WordLabel({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Text(
        word.content,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 16,
        ),
        overflow: TextOverflow.fade,
      ),
    );
  }
}
