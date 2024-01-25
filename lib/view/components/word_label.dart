import 'package:aphasia/constants.dart';
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
      padding: const EdgeInsets.symmetric(
        horizontal: kMediumSize,
        vertical: kSmallSize,
      ),
      decoration: BoxDecoration(color: theme.primaryColor),
      child: Text(
        word.content,
        style: theme.textTheme.titleLarge!.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
        overflow: TextOverflow.fade,
      ),
    );
  }
}
