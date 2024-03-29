import 'dart:collection';

import 'package:aphasia/db/words_db.dart';
import 'package:aphasia/model/word.dart';
import 'package:flutter/material.dart';

enum WordFilter {
  all(
    label: "Tutte",
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home),
  ),
  favourites(
    label: "Preferite",
    icon: Icon(Icons.favorite_border),
    activeIcon: Icon(Icons.favorite),
  ),
  mostUsed(
    label: "Più usate",
    icon: Icon(Icons.star_border),
    activeIcon: Icon(Icons.star),
  );

  final String label;
  final Icon icon;
  final Icon activeIcon;

  const WordFilter({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

/// Provider class for the words saved by the user
class WordProvider extends ChangeNotifier {
  Future? isInitCompleted;
  final WordsDatabaseService _dataBaseService;

  List<Word> _words = [];

  WordProvider() : _dataBaseService = WordsDatabaseService() {
    isInitCompleted = init();
  }

  /// initializes the list of words with the fetched data from the local database.
  Future<void> init() async {
    _words = await _dataBaseService.getWords;
  }

  /// Adds the given `word` to the words provider list.
  ///
  /// If the word is already in the list it wont be added.
  void add(Word word) async {
    // searches if a word inside the words list has
    // the same content as the one the user is trying to insert.
    int index = _words.indexWhere(
      (Word element) => element.content == word.content,
    );

    // if a word was found, nothing is done.
    if (index != -1) return;

    // if no word found, insert the new word into the list.
    await _dataBaseService.add(word);
    _words.add(word);
    notifyListeners();
  }

  /// Removes the given `word` from the words list.
  void delete(Word word) async {
    await _dataBaseService.remove(word);
    _words.remove(word);
    notifyListeners();
  }

  void incrementCounter(Word word) {
    word.incrementCounter();
    _dataBaseService.update(word);
    notifyListeners();
  }

  /// Toggles the favourite flag on the given `word`.
  void toggleFavourite(Word word) async {
    word.toggleFavourite();
    await _dataBaseService.update(word);
    notifyListeners();
  }

  /// Adds the given `word` in the bin, in order to be deleted.
  void toggleSelected(Word word) {
    word.toggleSelected();
    notifyListeners();
  }

  void deleteBin() async {
    List<Word> toBeDeleted = getToBeDeletedWords.toList();

    for (Word word in toBeDeleted) {
      delete(word);
    }
  }

  /// Filters the words based on the given `filter`.
  UnmodifiableListView<Word> filterBy(WordFilter filter) {
    return switch (filter) {
      WordFilter.favourites => getFavouriteWords,
      WordFilter.mostUsed => getMostUsed,
      WordFilter.all => getAllWords,
    };
  }

  UnmodifiableListView<Word> get getAllWords {
    return UnmodifiableListView(_words);
  }

  UnmodifiableListView<Word> get getMostUsed {
    final copy = List<Word>.from(_words);

    copy.sort((a, b) => b.counter.compareTo(a.counter));
    return UnmodifiableListView(copy.take(10));
  }

  UnmodifiableListView<Word> get getFavouriteWords {
    return UnmodifiableListView(_words.where((Word word) => word.isFavourite));
  }

  UnmodifiableListView<Word> get getToBeDeletedWords {
    return UnmodifiableListView(_words.where((Word word) => word.isSelected));
  }

  int get getLength => _words.length;

  String getWordsCountString() {
    StringBuffer result = StringBuffer();
    if (_words.isEmpty) {
      result.write("Nessuna");
    } else {
      result.write(_words.length.toString());
    }

    if (_words.length <= 1) {
      result.write(" parola aggiunta");
    } else {
      result.write(" parole aggiunte");
    }

    return result.toString();
  }
}
