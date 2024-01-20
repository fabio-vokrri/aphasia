import 'package:flutter/material.dart';

class EditModeProvider extends ChangeNotifier {
  bool _isEditMode = false;

  void toggleEditMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }

  void exitEditMode() {
    if (_isEditMode) {
      _isEditMode = false;
      notifyListeners();
    }
  }

  bool get isEditMode => _isEditMode;
  Color get getColor {
    return _isEditMode ? Colors.red : Colors.blue;
  }
}
