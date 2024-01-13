import 'package:aphasia/model/word.dart';
import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final Word word;
  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TTS logic
      },
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          word.content,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
