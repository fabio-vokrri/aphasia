import 'dart:collection';

import 'package:aphasia/model/word.dart';
import 'package:flutter/material.dart';

enum WordFilter {
  all,
  favourites,
}

/// Provider class for the words saved by the user
class WordProvider extends ChangeNotifier {
  final List<Word> _words = [
    Word("Benvenuto!", isFavourite: true),
  ];

  /// # IMPLEMENT TRIE FOR FASTER SEARCHES!
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

  /// Toggles the favourite flag on the given `word`.
  void toggleFavourite(Word word) {
    word.toggleFavourite();
    notifyListeners();
  }

  UnmodifiableListView<Word> filter(WordFilter filter) {
    return switch (filter) {
      WordFilter.favourites => _getFavouriteWords,
      WordFilter.all => _getAllWords,
    };
  }

  UnmodifiableListView<Word> get _getAllWords {
    return UnmodifiableListView(_words);
  }

  UnmodifiableListView<Word> get _getFavouriteWords {
    return UnmodifiableListView(_words.where((Word word) => word.isFavourite));
  }
}
