import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double elevation;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;

  CustomButton({
    required this.onPressed,
    required this.text,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.elevation = 5,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor, // Color del texto
        elevation: elevation, // Sombra del botón
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius, // Bordes redondeados
        ),
        padding: padding, // Espaciado interno del botón
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold, // Negrita para mayor énfasis
        ),
      ),
    );
  }
}
