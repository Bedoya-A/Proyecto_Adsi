import 'package:flutter/material.dart';
import 'package:prueba2/DrawerHeaderBacground.dart';
import 'package:prueba2/DrawerHeaderContent.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          GradientAnimation(), // Gradiente animado
          HeaderContent(), // Contenido del encabezado
        ],
      ),
    );
  }
}
