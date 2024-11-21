import 'package:flutter/material.dart';

class AccesibilidadSection extends StatelessWidget {
  final bool atajosModificador;
  final bool contrasteAlto;
  final bool subtitulos;
  final Function(bool) onAtajosModificadorChanged;
  final Function(bool) onContrasteAltoChanged;
  final Function(bool) onSubtitulosChanged;

  AccesibilidadSection({
    required this.atajosModificador,
    required this.contrasteAlto,
    required this.subtitulos,
    required this.onAtajosModificadorChanged,
    required this.onContrasteAltoChanged,
    required this.onSubtitulosChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accesibilidad',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        // Aquí utilizamos un SingleChildScrollView para el cuerpo, para manejar el desbordamiento
        SingleChildScrollView(
          child: Column(
            children: [
              _buildAccesibilidadOption(
                'Atajos necesitan modificador',
                Icons.keyboard,
                atajosModificador,
                onAtajosModificadorChanged,
              ),
              _buildAccesibilidadOption(
                'Contraste alto de colores',
                Icons.contrast,
                contrasteAlto,
                onContrasteAltoChanged,
              ),
              _buildAccesibilidadOption(
                'Subtítulos',
                Icons.subtitles,
                subtitulos,
                onSubtitulosChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccesibilidadOption(
      String titulo, IconData icono, bool estado, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icono, color: Colors.red),
          SizedBox(width: 10),
          Expanded(
            child: SwitchListTile(
              title: Text(titulo),
              value: estado,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
