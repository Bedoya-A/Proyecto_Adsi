import 'package:flutter/material.dart';
import 'package:prueba2/intl_en.dart';
import 'package:prueba2/intl_es.dart';
import 'package:prueba2/intl_fr.dart';

class MyLocalizations {
  static MyLocalizations? of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  String get helloWorld {
    return '¡Hola Mundo!';
  }

  String get welcome {
    return 'Bienvenido a la aplicación';
  }

  String get login {
    return 'Iniciar sesión';
  }

  String get logout {
    return 'Cerrar sesión';
  }

  String get register {
    return 'Registrar';
  }
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['es', 'en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<MyLocalizations> load(Locale locale) {
    if (locale.languageCode == 'es') {
      return Future.value(
          MyLocalizations_es()); // Cargar traducciones en español
    } else if (locale.languageCode == 'en') {
      return Future.value(
          MyLocalizations_en()); // Cargar traducciones en inglés
    } else if (locale.languageCode == 'fr') {
      return Future.value(
          MyLocalizations_fr()); // Cargar traducciones en francés
    }
    return Future.value(
        MyLocalizations()); // Cargar traducción por defecto (español o el idioma que se considere)
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
