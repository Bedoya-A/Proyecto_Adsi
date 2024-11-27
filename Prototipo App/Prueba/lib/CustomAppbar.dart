import 'package:flutter/material.dart';
import 'package:prueba2/FotoPerfil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLoggedIn;
  final VoidCallback onUserIconPressed;
  final VoidCallback onMenuPressed;

  CustomAppBar({
    required this.isLoggedIn,
    required this.onUserIconPressed,
    required this.onMenuPressed,
    String? profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Calambeo - Ambalá",
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        // Si el usuario está logueado, se muestra la foto de perfil
        isLoggedIn
            ? GestureDetector(
                onTap:
                    onUserIconPressed, // Llamamos a la función cuando se toque el avatar
                child: FotoPerfil(
                  onTap: (context) =>
                      onUserIconPressed(), // Manejo correcto del onTap
                ),
              )
            : IconButton(
                icon: Icon(Icons.person),
                onPressed: onUserIconPressed,
              ),
        // Botón de menú
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: onMenuPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
