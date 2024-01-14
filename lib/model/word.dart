import 'dart:collection';
import 'dart:io';

class Word {
  final String content;
  final List<File> _images = [];

  Word(this.content);

  void addAllImages(List<File> images) {
    _images.addAll(images);
  }

  UnmodifiableListView<File> get getImages => UnmodifiableListView(_images);
}
