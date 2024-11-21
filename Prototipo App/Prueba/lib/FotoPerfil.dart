import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/ModeloEstado.dart';

class FotoPerfil extends StatelessWidget {
  final Function(BuildContext) onTap;
  final double fotoSize; // Añadir este parámetro

  FotoPerfil(
      {required this.onTap, this.fotoSize = 20.0}); // Valor por defecto 40

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return GestureDetector(
      onTap: () => onTap(context),
      child: CircleAvatar(
        radius: fotoSize, // Usar el parámetro para el tamaño de la foto
        backgroundImage: appState.fotoPerfil != null
            ? FileImage(appState.fotoPerfil!)
            : AssetImage('assets/logo.png') as ImageProvider,
      ),
    );
  }
}
