import 'dart:typed_data';

class Word {
  final String _content;
  bool _isFavourite;
  bool _isSelected;
  Uint8List? _image;
  int _counter;

  Word(
    String content, {
    bool isFavourite = false,
    bool isSelected = false,
    int counter = 0,
    Uint8List? image,
  })  : _content = content,
        _isFavourite = isFavourite,
        _isSelected = isSelected,
        _counter = counter,
        _image = image;

  Map<String, dynamic> toMap() {
    return {
      "id": _content,
      "isFavourite": _isFavourite ? 1 : 0,
      "image": _image,
      "counter": _counter,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      map["id"],
      isFavourite: map["isFavourite"] == 1,
      image: map["image"],
      counter: map["counter"],
    );
  }

  String get content => _content;
  String get id => _content;
  int get counter => _counter;
  bool get isFavourite => _isFavourite;
  bool get isSelected => _isSelected;

  void incrementCounter() {
    _counter++;
  }

  Uint8List? get image {
    return _image;
  }

  void toggleFavourite() {
    _isFavourite = !_isFavourite;
  }

  void toggleSelected() {
    _isSelected = !_isSelected;
  }
}
