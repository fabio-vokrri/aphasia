import 'dart:collection';

import 'package:aphasia/model/word.dart';
import 'package:flutter/material.dart';

class WordProvider extends ChangeNotifier {
  final List<Word> _words = [];

  void add(Word word) {
    _words.add(word);
    notifyListeners();
  }

  void delete(Word word) {
    _words.remove(word);
    notifyListeners();
  }

  bool get isEmpty => _words.isEmpty;
  UnmodifiableListView<Word> get getWords => UnmodifiableListView(_words);
}
