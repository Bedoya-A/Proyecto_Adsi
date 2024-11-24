import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Búsquedas Recientes',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.cyanAccent, // Color principal (Cyan)
          secondary: Colors.blueAccent, // Color secundario
        ),
        scaffoldBackgroundColor: Colors.black87, // Fondo oscuro
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.white), // Título grande
          bodyLarge: TextStyle(color: Colors.white70), // Texto grande
        ),
      ),
      home: RecentSearchPage(),
    );
  }
}

class RecentSearchPage extends StatefulWidget {
  @override
  _RecentSearchPageState createState() => _RecentSearchPageState();
}

class _RecentSearchPageState extends State<RecentSearchPage> {
  List<Map<String, dynamic>> recentSearches = [
    {
      'name': 'Parque Temático Meraki',
      'date': '2024-11-22',
      'image': 'assets/meraki1.png',
      'isFavorite': false,
      'popularity': 5,
    },
    {
      'name': 'Mirador Tesorito',
      'date': '2024-11-21',
      'image': 'assets/tesorito2.jpg',
      'isFavorite': true,
      'popularity': 8,
    },
    {
      'name': 'Auctotonos',
      'date': '2024-11-20',
      'image': 'assets/autoctonos1.jpg',
      'isFavorite': false,
      'popularity': 6,
    },
    {
      'name': 'Jardín Botánico',
      'date': '2024-11-19',
      'image': 'assets/aves.jpg',
      'isFavorite': true,
      'popularity': 7,
    },
    {
      'name': 'Paraíso Escondido',
      'date': '2024-11-18',
      'image': 'assets/montaña5.png',
      'isFavorite': false,
      'popularity': 9,
    },
  ];

  List<Map<String, dynamic>> filteredSearches = [];
  bool isDarkMode = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredSearches = recentSearches;
  }

  void filterSearchResults(String query) {
    setState(() {
      searchQuery = query;
      filteredSearches = recentSearches
          .where((search) =>
              search['name'].toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  void toggleFavorite(int index) {
    setState(() {
      recentSearches[index]['isFavorite'] =
          !recentSearches[index]['isFavorite'];
      filteredSearches[index]['isFavorite'] =
          !filteredSearches[index]['isFavorite'];
    });
  }

  void clearHistory() {
    setState(() {
      filteredSearches = [];
      recentSearches = [];
    });
  }

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
            onPressed: clearHistory,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título futurista con efecto de sombra
              Text(
                'Destinos que has buscado',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      color: Colors.blue.withOpacity(0.7),
                      offset: Offset(2, 2),
                      blurRadius: 8,
                    ),
                    Shadow(
                      color: Colors.purple.withOpacity(0.4),
                      offset: Offset(-2, -2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Descripción debajo del título
              Text(
                'Explora los destinos más recientes que has buscado. Accede a tus lugares favoritos y encuentra nuevos destinos.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20),
              // Búsqueda en tiempo real
              TextField(
                onChanged: filterSearchResults,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.cyanAccent),
                  hintText: 'Buscar destino...',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Lista de resultados
              filteredSearches.isEmpty
                  ? Center(
                      child: Text(
                        'No se encontraron resultados.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : RecentSearchList(
                      recentSearches: filteredSearches,
                      toggleFavorite: toggleFavorite,
                    ),
              SizedBox(height: 30),
              // Sección de búsquedas populares
              Text(
                'Búsquedas Populares',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                ),
              ),
              SizedBox(height: 10),
              PopularSearchList(recentSearches: recentSearches),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        onPressed: () {
          print('Botón flotante presionado');
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

class RecentSearchList extends StatelessWidget {
  final List<Map<String, dynamic>> recentSearches;
  final Function(int) toggleFavorite;

  RecentSearchList(
      {required this.recentSearches, required this.toggleFavorite});

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
          isFavorite: recentSearches[index]['isFavorite'],
          onFavoriteToggle: () => toggleFavorite(index),
        );
      },
    );
  }
}

class RecentSearchCard extends StatelessWidget {
  final String destination;
  final String date;
  final String image;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  RecentSearchCard({
    required this.destination,
    required this.date,
    required this.image,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GestureDetector(
        onTap: () {
          print('Destino seleccionado: $destination');
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyanAccent.withOpacity(0.8),
                Colors.blueAccent.withOpacity(0.5)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 3,
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
                  width: 60,
                  height: 60,
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
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.redAccent : Colors.white,
                  size: 30,
                ),
                onPressed: onFavoriteToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularSearchList extends StatelessWidget {
  final List<Map<String, dynamic>> recentSearches;

  PopularSearchList({required this.recentSearches});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: recentSearches.length,
      itemBuilder: (context, index) {
        if (recentSearches[index]['popularity'] > 7) {
          return PopularSearchCard(
            destination: recentSearches[index]['name'],
            popularity: recentSearches[index]['popularity'],
            image: recentSearches[index]['image'],
          );
        }
        return SizedBox.shrink(); // No mostrar si la popularidad es baja
      },
    );
  }
}

class PopularSearchCard extends StatelessWidget {
  final String destination;
  final int popularity;
  final String image;

  PopularSearchCard({
    required this.destination,
    required this.popularity,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
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
              child: Text(
                destination,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '$popularity%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
