import 'package:flutter/material.dart';
import 'package:prueba2/CabanaDelArbol.dart';
import 'package:prueba2/CabanaEncanto.dart';
import 'package:prueba2/CabanaLaMontana.dart';
import 'package:prueba2/CabanaParaisoEscondido.dart';

class Cabanas extends StatelessWidget {
  // Lista de cabañas con información única
  final List<Map<String, dynamic>> cabanas = [
    {
      "title": "Cabaña Paraíso",
      "image": "assets/paraiso.png",
      "description":
          "Un lugar acogedor con vistas increíbles y mucha tranquilidad.",
      "screen": CabanaParaisoEscondido(),
    },
    {
      "title": "Cabaña del Árbol",
      "image": "assets/arbol.png",
      "description":
          "Vive la experiencia única de alojarte entre las copas de los árboles.",
      "screen": CabanaDelArbol(),
    },
    {
      "title": "Cabaña la Montaña",
      "image": "assets/montaña.png",
      "description": "Relájate en una cabaña rodeada de montañas y naturaleza.",
      "screen": CabanaLaMontana(),
    },
    {
      "title": "Cabaña el Encanto",
      "image": "assets/encanto.png",
      "description": "Un espacio mágico ideal para desconectarte del mundo.",
      "screen": const CabanaEncanto(),
    },
    // Agrega más cabañas aquí con sus datos únicos
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cabañas que ofrece El Paraiso Escondido',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 79, 76, 164),
              ),
            ),
            SizedBox(height: 10),
            // Construye dinámicamente las tarjetas de cabañas
            for (var cabana in cabanas)
              _buildServiceItem(
                context,
                cabana['title'],
                cabana['image'],
                cabana['description'],
                cabana['screen'],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String title, String image,
      String description, Widget screen) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen pequeña
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bordes redondeados
              child: Image.asset(
                image,
                width: 80, // Ajusta el ancho de la imagen
                height: 80, // Ajusta la altura de la imagen
                fit: BoxFit.cover, // Ajusta la imagen al contenedor
              ),
            ),
            SizedBox(width: 10),
            // Contenido: título, descripción y botón
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: const Color.fromARGB(255, 46, 70, 125),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft, // Ajustar alineación
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => screen),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 88, 78, 161),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Ver más",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
