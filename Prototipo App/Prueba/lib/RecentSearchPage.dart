import 'package:flutter/material.dart';

class RecentSearchPage extends StatelessWidget {
  final List<Map<String, dynamic>> recentSearches = [
    {
      'name': 'Parque Temático Meraki',
      'date': '2024-11-22',
      'image': 'assets/parque.jpg'
    },
    {
      'name': 'Mirador Tesorito',
      'date': '2024-11-21',
      'image': 'assets/tesorito.jpg'
    },
    {
      'name': 'Auctotonos',
      'date': '2024-11-20',
      'image': 'assets/auctotonos.jpg'
    },
    {
      'name': 'Jardín Botánico',
      'date': '2024-11-19',
      'image': 'assets/jardin_botanico.jpg'
    },
    {
      'name': 'Paraíso Escondido',
      'date': '2024-11-18',
      'image': 'assets/paraiso.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Búsquedas Recientes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever, color: Colors.redAccent),
            onPressed: () {
              // Función para eliminar todo el historial
              print('Se ha borrado todo el historial');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Destinos que has buscado',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                  shadows: [
                    Shadow(
                        color: Colors.blue, offset: Offset(0, 2), blurRadius: 3)
                  ],
                ),
              ),
              SizedBox(height: 20),
              RecentSearchList(recentSearches: recentSearches),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentSearchList extends StatelessWidget {
  final List<Map<String, dynamic>> recentSearches;

  RecentSearchList({required this.recentSearches});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: recentSearches.length,
      itemBuilder: (context, index) {
        return RecentSearchCard(
          destination: recentSearches[index]['name'],
          date: recentSearches[index]['date'],
          image: recentSearches[index]['image'],
        );
      },
    );
  }
}

class RecentSearchCard extends StatelessWidget {
  final String destination;
  final String date;
  final String image;

  RecentSearchCard(
      {required this.destination, required this.date, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyanAccent.withOpacity(0.6),
              Colors.blueAccent.withOpacity(0.2)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Última búsqueda: $date',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent, size: 28),
              onPressed: () {
                // Función de eliminar búsqueda
                print('Búsqueda eliminada: $destination');
              },
            ),
          ],
        ),
      ),
    );
  }
}
