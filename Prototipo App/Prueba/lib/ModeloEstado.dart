import 'dart:io';

import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String _nombreUsuario = "Usuario";
  String _correoUsuario = "adsi@gmail.com";
  int _currentPage = 0;
  int _selectedDrawerIndex = 0;
  bool _isLoggedIn =
      false; // Variable para gestionar si el usuario está logueado
  File? _fotoPerfil; // Nueva propiedad para la foto de perfil
  ThemeMode _themeMode = ThemeMode.system;

  int get currentPage => _currentPage;
  int get selectedDrawerIndex => _selectedDrawerIndex;
  bool get isLoggedIn => _isLoggedIn; // Getter para isLoggedIn
  String get nombreUsuario => _nombreUsuario;
  String get correoUsuario => _correoUsuario;
  File? get fotoPerfil => _fotoPerfil; // Getter para la foto de perfil
  // Getter para el themeMode
  ThemeMode get themeMode => _themeMode;

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

  void setNombreUsuario(String nuevoNombre) {
    _nombreUsuario = nuevoNombre;
    notifyListeners(); // Notifica a los widgets dependientes para redibujar
  }

  void setCorreoUsuario(String nuevoCorreo) {
    _correoUsuario = nuevoCorreo;
    notifyListeners();
  }

  void setFotoPerfil(File? nuevaFoto) {
    _fotoPerfil = nuevaFoto;
    notifyListeners(); // Notifica a todos los widgets dependientes
  }

  // Método para cambiar el tema
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners(); // Notificar a todos los listeners (widgets) sobre el cambio
  }

  void logOut() {
    _nombreUsuario = "Usuario";
    _correoUsuario = "adsi@gmail.com";
    _fotoPerfil = null;
    notifyListeners();
  }
}
