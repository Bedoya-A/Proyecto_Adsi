import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  int _currentPage = 0;
  int _selectedDrawerIndex = 0;
  bool _isLoggedIn =
      false; // Variable para gestionar si el usuario está logueado

  int get currentPage => _currentPage;
  int get selectedDrawerIndex => _selectedDrawerIndex;
  bool get isLoggedIn => _isLoggedIn; // Getter para isLoggedIn

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void setSelectedDrawerIndex(int index) {
    _selectedDrawerIndex = index;
    notifyListeners();
  }

  void setLoginStatus(bool status) {
    _isLoggedIn = status;
    notifyListeners();
  }

  void logOut() {
    setLoginStatus(false); // Usamos la misma función para mantener consistencia
  }
}
