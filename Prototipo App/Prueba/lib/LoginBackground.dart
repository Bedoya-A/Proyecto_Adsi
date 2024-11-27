import 'dart:ui'; // Necesario para el BackdropFilter
import 'package:flutter/material.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;
  final String imageAsset; // Parámetro para la imagen de fondo

  const BackgroundWrapper({required this.child, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagen de fondo, pasa el asset dinámicamente
        Positioned.fill(
          child: Image.asset(
            imageAsset, // Aquí se pasa la imagen dinámica
            fit: BoxFit.cover,
          ),
        ),
        // Efecto Blur sobre la imagen
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 1.0, sigmaY: 1.0), // Efecto de desenfoque
            child: Container(
              color: Colors.black
                  .withOpacity(0.5), // Fondo oscuro semitransparente
            ),
          ),
        ),
        // El contenido de la página (que recibe el fondo)
        child,
      ],
    );
  }
}
