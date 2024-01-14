import 'package:aphasia/model/word.dart';
import 'package:aphasia/view/components/delete_dialog.dart';
import 'package:aphasia/view/components/word_label.dart';
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
  void initState() {
    initTTS();
    super.initState();
  }

  Future<void> initTTS() async {
    await tts.setVolume(1);
    await tts.setLanguage("it");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tts.speak(widget.word.content),
      onLongPress: () => showDialog(
        context: context,
        builder: (context) {
          return DeleteDialog(word: widget.word);
        },
      ),
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
