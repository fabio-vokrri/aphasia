import 'dart:typed_data';

class Word {
  final String _content;
  bool _isFavourite;
  int _counter;
  Uint8List? _image;
  bool _isSelected;

  Word(
    String content, {
    bool isFavourite = false,
    int counter = 0,
    Uint8List? image,
    bool isSelected = false,
  })  : _content = content,
        _isFavourite = isFavourite,
        _isSelected = isSelected,
        _image = image,
        _counter = counter;

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
      counter: map["counter"],
      image: map["image"],
    );
  }

  String get content => _content;
  String get id => _content;
  bool get isFavourite => _isFavourite;
  int get counter => _counter;
  Uint8List? get image => _image;
  bool get isSelected => _isSelected;

  void toggleFavourite() => _isFavourite = !_isFavourite;
  void toggleSelected() => _isSelected = !_isSelected;
  void incrementCounter() => _counter++;
}
