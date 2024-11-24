import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha

class AccountHistoryPage extends StatefulWidget {
  @override
  _AccountHistoryPageState createState() => _AccountHistoryPageState();
}

class _AccountHistoryPageState extends State<AccountHistoryPage> {
  final List<Map<String, dynamic>> destinations = [
    {
      'name': 'Parque Temático Meraki',
      'rating': 4.5,
      'points': 120,
      'image': 'assets/meraki1.png',
      'date': DateTime(2024, 5, 10),
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
    totalPoints = destinations.fold(0, (sum, destination) {
      return sum + (destination['points'] as int);
    });
  }

  List<Map<String, dynamic>> getFilteredDestinations() {
    return destinations
        .where((destination) => destination['name']
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade200, Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Aquí puedes ver un resumen de tus puntos de fidelidad acumulados por los destinos que has visitado. También puedes calificar los lugares para dejar tu opinión sobre tu experiencia.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Puntos de Fidelidad: $totalPoints',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
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
                                Colors.lightBlueAccent.withOpacity(0.8),
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
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () async {
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
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.orange.shade400,
                                          Colors.redAccent,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.redAccent.withOpacity(0.5),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                          offset: Offset(0, 3),
                                        ),
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.3),
                                          blurRadius: 6,
                                          offset: Offset(-2, -2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star_rate_rounded,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Calificar',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
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
      ),
    );
  }
}

class RatingDialog extends StatefulWidget {
  final double initialRating;

  RatingDialog({required this.initialRating});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Califica tu experiencia'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: rating,
            min: 1.0,
            max: 5.0,
            divisions: 4,
            onChanged: (newRating) {
              setState(() {
                rating = newRating;
              });
            },
          ),
          Text(
            'Rating: ${rating.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, rating);
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
