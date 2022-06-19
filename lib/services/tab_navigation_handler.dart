import 'package:flutter/material.dart';

class TabNavigatorHandler extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  set selectedTab(int tab) {
    _selectedTab = tab;
    notifyListeners();
  }
}