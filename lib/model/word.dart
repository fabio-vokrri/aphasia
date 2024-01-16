import 'dart:typed_data';

class Word {
  final String _content;
  bool _isFavourite;
  Uint8List? _image;

  Word(
    String content, {
    bool isFavourite = false,
    Uint8List? image,
  })  : _content = content,
        _isFavourite = isFavourite,
        _image = image;

  Map<String, dynamic> toMap() {
    return {
      "id": _content,
      "isFavourite": _isFavourite ? 1 : 0,
      "image": _image,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      map["id"],
      isFavourite: map["isFavourite"] == 1,
      image: map["image"],
    );
  }

  String get getContent => _content;
  String get getId => _content;
  bool get isFavourite => _isFavourite;

  Uint8List? get getImage {
    return _image;
  }

  void toggleFavourite() {
    _isFavourite = !_isFavourite;
  }
}
