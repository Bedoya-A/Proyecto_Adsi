import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/AccesibilidadSeccion.dart';
import 'package:prueba2/EditableField.dart';
import 'package:prueba2/FotoPerfil.dart';
import 'package:prueba2/ModeloEstado.dart';
import 'package:prueba2/TemaSeleccion.dart';

class MiCuentaPage extends StatefulWidget {
  @override
  _MiCuentaPageState createState() => _MiCuentaPageState();
}

class _MiCuentaPageState extends State<MiCuentaPage> {
  // Variables para el tema
  ThemeMode _themeMode = ThemeMode.system;
  int _temaSeleccionado = 0; // 0: Sistema, 1: Claro, 2: Oscuro

  // Variables para accesibilidad
  bool _atajosModificador = false;
  bool _contrasteAlto = false;
  bool _subtitulos = false;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Cuenta'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto de perfil centrada y con tamaño 50
            Center(
              child: FotoPerfil(
                onTap: _cambiarFotoPerfil,
                // Pasando el tamaño 50 para la foto de perfil
                fotoSize: 50.0,
              ),
            ),

            SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () => _cambiarFotoPerfil(context),
                child: Text(
                  'Cambiar la foto',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            Divider(),

            // Campos editables
            EditableField(
              titulo: 'Nombre',
              valor: appState.nombreUsuario,
              icono: Icons.person,
              onSave: (nuevoValor) {
                appState.setNombreUsuario(nuevoValor);
              },
            ),
            Divider(),
            EditableField(
              titulo: 'Correo electrónico',
              valor: appState.correoUsuario,
              icono: Icons.email,
              onSave: (nuevoValor) {
                appState.setCorreoUsuario(nuevoValor);
              },
            ),
            Divider(),

            // Sección de Tema
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TemaSection(
                temaSeleccionado: _temaSeleccionado,
                onTemaChange: (index) {
                  setState(() {
                    _temaSeleccionado = index;
                    // Cambia el tema en AppState cuando el usuario selecciona uno
                    if (index == 0) {
                      appState.setThemeMode(ThemeMode.system);
                    } else if (index == 1) {
                      appState.setThemeMode(ThemeMode.light);
                    } else {
                      appState.setThemeMode(ThemeMode.dark);
                    }
                  });
                },
              ),
            ),
            Divider(),

            // Sección de Accesibilidad
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: AccesibilidadSection(
                atajosModificador: _atajosModificador,
                contrasteAlto: _contrasteAlto,
                subtitulos: _subtitulos,
                onAtajosModificadorChanged: (valor) {
                  setState(() {
                    _atajosModificador = valor;
                  });
                },
                onContrasteAltoChanged: (valor) {
                  setState(() {
                    _contrasteAlto = valor;
                  });
                },
                onSubtitulosChanged: (valor) {
                  setState(() {
                    _subtitulos = valor;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cambiarFotoPerfil(BuildContext context) async {
    // Funcionalidad para cambiar la foto
  }
}