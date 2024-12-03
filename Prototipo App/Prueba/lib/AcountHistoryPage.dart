import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prueba2/RatingDialog.dart';

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
        backgroundColor: Colors.teal.shade300, // Color más suave y tranquilo
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100, // Fondo neutro y suave
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
                        colors: [
                          const Color.fromARGB(255, 101, 160, 154),
                          Colors.teal.shade300
                        ], // Gradiente más sutil
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      'Historial de Recompensas y Destinos Visitados',
                      style: TextStyle(
                        fontSize: 26,
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
                    color: Colors.black87, // Gris oscuro y claro
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Puntos de Fidelidad: $totalPoints',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
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
                            color: Colors.white, // Fondo blanco más neutro
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.2), // Sombra suave
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                            color:
                                                Colors.black87, // Gris oscuro
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber
                                                  .shade600, // Amarillo suave
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '${destination['rating']}',
                                              style: TextStyle(
                                                color: Colors.black87,
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
                                              color: Colors.green
                                                  .shade600, // Verde suave
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              'Puntos: ${destination['points']}',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Visitado el: ${formatDate(destination['date'])}',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              GestureDetector(
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
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 101, 158, 152), // Botón suave
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.teal
                                            .withOpacity(0.3), // Sombra ligera
                                        blurRadius: 6,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'Calificar Destino',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
