import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  int _currentPage = 0;
  int _selectedDrawerIndex = 0;

  int get currentPage => _currentPage;
  int get selectedDrawerIndex => _selectedDrawerIndex;

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void setSelectedDrawerIndex(int index) {
    _selectedDrawerIndex = index;
    notifyListeners();
  }
}
