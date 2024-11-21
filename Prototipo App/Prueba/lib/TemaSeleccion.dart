import 'package:flutter/material.dart';

class TemaSection extends StatelessWidget {
  final int temaSeleccionado;
  final Function(int) onTemaChange;

  TemaSection({
    required this.temaSeleccionado,
    required this.onTemaChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tema',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),

        // SingleChildScrollView para evitar el desbordamiento en pantallas pequeñas
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTemaOption('Sincronizar con el sistema', 0),
              _buildTemaOption('Claro', 1),
              _buildTemaOption('Oscuro', 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTemaOption(String titulo, int index) {
    return GestureDetector(
      onTap: () {
        onTemaChange(index);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(
            horizontal: 5), // Añadir un margen para separación
        decoration: BoxDecoration(
          border: Border.all(
            color: temaSeleccionado == index ? Colors.blue : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(
              index == 0
                  ? Icons.phone_android
                  : (index == 1 ? Icons.light_mode : Icons.dark_mode),
              color: temaSeleccionado == index ? Colors.blue : Colors.grey,
            ),
            SizedBox(height: 5),
            Text(
              titulo,
              style: TextStyle(
                color: temaSeleccionado == index ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
