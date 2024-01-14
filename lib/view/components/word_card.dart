import 'package:aphasia/model/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class WordCard extends StatefulWidget {
  const WordCard({super.key, required this.word});

  final Word word;

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  final tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tts.speak(widget.word.content),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Stack(
            children: [
              PageView.builder(
                itemCount: widget.word.getImages.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    widget.word.getImages[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: WordLabel(word: widget.word),
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
