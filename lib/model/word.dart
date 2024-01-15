import 'dart:collection';
import 'dart:io';

class Word {
  final String _content;
  bool _isFavourite;
  final List<File> _images = [];

  Word(String content, {bool isFavourite = false})
      : _content = content,
        _isFavourite = isFavourite;

  Map<String, dynamic> toMap() {
    return {
      "id": _content,
      "isFavourite": _isFavourite ? 1 : 0,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      map["id"],
      isFavourite: map["isFavourite"] == 1,
    );
  }

  String get getContent => _content;
  String get getId => _content;
  bool get isFavourite => _isFavourite;
  UnmodifiableListView<File> get getImages {
    return UnmodifiableListView(_images);
  }

  void addImage(File image) {
    _images.add(image);
  }

  void addAllImages(List<File> images) {
    _images.addAll(images);
  }

  void toggleFavourite() {
    _isFavourite = !_isFavourite;
  }
}
