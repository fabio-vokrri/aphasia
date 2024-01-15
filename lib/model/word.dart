import 'dart:collection';
import 'dart:io';

class Word {
  final String content;
  final List<File> _images = [];
  bool _isFavourite;

  Word(this.content, {bool isFavourite = false}) : _isFavourite = isFavourite;

  void addAllImages(List<File> images) {
    _images.addAll(images);
  }

  void toggleFavourite() {
    _isFavourite = !_isFavourite;
  }

  bool get isFavourite => _isFavourite;
  UnmodifiableListView<File> get getImages => UnmodifiableListView(_images);
}
