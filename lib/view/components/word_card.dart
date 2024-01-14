import 'package:aphasia/model/word.dart';
import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  const WordCard({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TTS logic
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Stack(
            children: [
              PageView.builder(
                itemCount: word.getImages.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    word.getImages[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: WordLabel(word: word),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        style: const TextStyle(color: Colors.white, fontSize: 16),
        overflow: TextOverflow.fade,
      ),
    );
  }
}
