import 'dart:collection';

import 'package:aphasia/model/word.dart';
import 'package:flutter/material.dart';

/// Provider class for the words saved by the user
class WordProvider extends ChangeNotifier {
  final List<Word> _words = [
    Word("Ciao!"),
  ];

  /// # IMPLEMENT TRIE FOR FASTER SEARCHES.
  ///
  /// Adds the given `word` to the words provider list.
  ///
  /// If the word is already in the list,
  /// it wont be added and false is returned.
  /// Returns true otherwise.
  bool add(Word word) {
    // searches if a word inside the _words list has
    // the same content as the one the user is trying to insert.
    int index = _words.indexWhere(
      (Word element) => element.content == word.content,
    );

    // if a word was found, returns false.
    if (index != -1) return false;

    // if no word found, insert the new word into the list.
    _words.add(word);
    notifyListeners();
    return true;
  }

  /// Removes the given `word` from the words list.
  void delete(Word word) {
    _words.remove(word);
    notifyListeners();
  }

  bool get isEmpty => _words.isEmpty;
  UnmodifiableListView<Word> get getWords => UnmodifiableListView(_words);
}
