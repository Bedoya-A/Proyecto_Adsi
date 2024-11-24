import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha

class AccountHistoryPage extends StatefulWidget {
  @override
  _AccountHistoryPageState createState() => _AccountHistoryPageState();
}

class _AccountHistoryPageState extends State<AccountHistoryPage> {
  // Lista de destinos con calificación, puntos de fidelidad y fecha de visita
  final List<Map<String, dynamic>> destinations = [
    {
      'name': 'Parque Temático Meraki',
      'rating': 4.5,
      'points': 120,
      'image': 'assets/meraki1.png',
      'date': DateTime(2024, 5, 10), // Fecha de visita
    },
    {
      'name': 'Mirador Tesorito',
      'rating': 4.0,
      'points': 80,
      'image': 'assets/tesorito2.jpg',
      'date': DateTime(2024, 6, 15),
    },
    {
      'name': 'Auctotonos',
      'rating': 5.0,
      'points': 200,
      'image': 'assets/autoctonos1.jpg',
      'date': DateTime(2024, 7, 20),
    },
    {
      'name': 'Jardín Botánico',
      'rating': 4.7,
      'points': 150,
      'image': 'assets/aves.jpg',
      'date': DateTime(2024, 8, 5),
    },
    {
      'name': 'Paraíso Escondido',
      'rating': 4.2,
      'points': 90,
      'image': 'assets/montaña5.png',
      'date': DateTime(2024, 9, 10),
    },
  ];

  int totalPoints = 0;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Calculamos el total de puntos de fidelidad al principio
    totalPoints = destinations.fold(0, (sum, destination) {
      return sum + (destination['points'] as int);
    });
  }

  // Función para filtrar los destinos según la búsqueda
  List<Map<String, dynamic>> getFilteredDestinations() {
    return destinations
        .where((destination) => destination['name']
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }

  // Formatear la fecha en un formato legible
  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Función para actualizar la calificación de un destino
  void updateRating(int index, double rating) {
    setState(() {
      destinations[index]['rating'] = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de la Cuenta"),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título con degradado y centrado
              Center(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.cyan, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    'Historial de Recompensas y Destinos Visitados',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // El color blanco es necesario para que el degradado sea visible
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Aquí puedes ver un resumen de tus puntos de fidelidad acumulados por los destinos que has visitado. También puedes calificar los lugares para dejar tu opinión sobre tu experiencia.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),

              // Sección de puntos de fidelidad
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Puntos de Fidelidad: $totalPoints',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              // Campo de búsqueda
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Buscar un destino',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              SizedBox(height: 20),

              // Lista de destinos filtrados
              ListView.builder(
                shrinkWrap: true,
                itemCount: getFilteredDestinations().length,
                itemBuilder: (context, index) {
                  final destination = getFilteredDestinations()[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Destino seleccionado: ${destination['name']}');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.cyanAccent.withOpacity(0.8),
                              Colors.blueAccent.withOpacity(0.5),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    destination['image'],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        destination['name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '${destination['rating']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.card_giftcard,
                                            color: Colors.greenAccent,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Puntos: ${destination['points']}',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      // Fecha de visita
                                      Text(
                                        'Visitado el: ${formatDate(destination['date'])}',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Botón de calificación en la esquina
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: ElevatedButton(
                                onPressed: () async {
                                  double? newRating = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return RatingDialog(
                                        initialRating: destination['rating'],
                                      );
                                    },
                                  );

                                  if (newRating != null) {
                                    updateRating(index, newRating);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dialogo para calificar un destino
class RatingDialog extends StatefulWidget {
  final double initialRating;

  RatingDialog({required this.initialRating});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Calificar Destino'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: _rating,
            min: 0,
            max: 5,
            divisions: 5,
            onChanged: (newRating) {
              setState(() {
                _rating = newRating;
              });
            },
          ),
          Text('${_rating.toStringAsFixed(1)} estrellas'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_rating);
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
