import 'package:aphasia/view/pages/home.dart';
import 'package:aphasia/view/pages/settings_page.dart';
import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int _index = 0;
  final List<Widget> _pages = const [HomePage(), SettingsPage()];

  void setIndexTo(int index) {
    _index = index;
    notifyListeners();
  }

  int get getIndex => _index;
  Widget get getPage => _pages[_index];
}
