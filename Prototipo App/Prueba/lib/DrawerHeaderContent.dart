import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prueba2/InicioSesion.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/MiCuentaPage.dart';
import 'package:prueba2/ModeloEstado.dart';

class HeaderContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          // Obtenemos el estado del usuario desde AppState
          bool isLoggedIn = appState.isLoggedIn;
          File? fotoPerfil = appState.fotoPerfil;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (isLoggedIn) {
                    // Si está logueado, va al perfil
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MiCuentaPage()),
                    );
                  } else {
                    // Si no está logueado, muestra la pantalla de login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: isLoggedIn
                      ? (fotoPerfil != null
                          ? FileImage(fotoPerfil) // Si tiene foto de perfil
                          : AssetImage('assets/logo.png')
                              as ImageProvider) // Si no tiene foto, muestra el logo
                      : null, // Si no está logueado, no muestra ninguna imagen
                  backgroundColor: isLoggedIn
                      ? Colors
                          .transparent // Si está logueado, fondo transparente
                      : Colors.teal[
                          300], // Si no está logueado, color de fondo gris claro
                  child: !isLoggedIn || fotoPerfil == null
                      ? Icon(Icons.person,
                          size:
                              30) // Si no está logueado o no tiene foto, muestra el ícono
                      : null,
                ),
              ),
              SizedBox(height: 10),
              Text(
                isLoggedIn
                    ? '¡Hola, ${appState.nombreUsuario}!' // Si está logueado, muestra el nombre del usuario
                    : 'Inicia sesión para explorar más',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isLoggedIn)
                Text(
                  appState.correoUsuario, // Muestra el correo si está logueado
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
