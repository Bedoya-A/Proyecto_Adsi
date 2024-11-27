import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/ModeloEstado.dart';

class LanguageSwitchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return ElevatedButton(
          onPressed: () {
            _showLanguageDialog(context, appState);
          },
          child: Text(
            'Seleccionar Idioma',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 144, 255, 168)),
          ),
        );
      },
    );
  }

  // Mostrar el cuadro de diálogo para elegir el idioma
  void _showLanguageDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Español'),
                onTap: () {
                  appState.setLocale(Locale('es', ''));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('English'),
                onTap: () {
                  appState.setLocale(Locale('en', ''));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Francés'),
                onTap: () {
                  appState.setLocale(Locale('fr', ''));
                  Navigator.of(context).pop();
                },
              ),
              // Agregar más idiomas aquí si lo necesitas
            ],
          ),
        );
      },
    );
  }
}
