import 'package:flutter/material.dart';

class RecentSearchPage extends StatefulWidget {
  @override
  _RecentSearchPageState createState() => _RecentSearchPageState();
}

class _RecentSearchPageState extends State<RecentSearchPage> {
  List<Map<String, dynamic>> recentSearches = [
    {
      'name': 'Parque Meraki',
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
  String searchQuery = '';
  DateTime selectedDate = DateTime.now();

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busqueda Reciente'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título con centrado y degradado
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.cyanAccent, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Búsquedas Recientes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Descripción de la página
                Text(
                  'Explora tus búsquedas recientes y los destinos más populares. ¡Dales "me gusta" y disfruta de tu experiencia!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 20),
                // Fecha seleccionada
                Text(
                  'Fecha seleccionada: ${selectedDate.toLocal()}'.split(' ')[0],
                  style: TextStyle(color: Colors.white70, fontSize: 16),
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
                    fillColor: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.2),
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
                        onFavoriteChanged: _onFavoriteChanged,
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
      ),
    );
  }

  void _onFavoriteChanged(int index) {
    setState(() {
      recentSearches[index]['isFavorite'] =
          !recentSearches[index]['isFavorite'];
    });
  }
}

class RecentSearchList extends StatelessWidget {
  final List<Map<String, dynamic>> recentSearches;
  final Function(int) onFavoriteChanged;

  RecentSearchList(
      {required this.recentSearches, required this.onFavoriteChanged});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: recentSearches.length,
      itemBuilder: (context, index) {
        return RecentSearchCard(
          destination: recentSearches[index]['name'],
          date: recentSearches[index]['date'],
          image: recentSearches[index]['image'],
          isFavorite: recentSearches[index]['isFavorite'],
          onFavoriteChanged: () => onFavoriteChanged(index),
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
  final VoidCallback onFavoriteChanged;

  RecentSearchCard({
    required this.destination,
    required this.date,
    required this.image,
    required this.isFavorite,
    required this.onFavoriteChanged,
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Fecha: $date',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: onFavoriteChanged,
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
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentSearches.length,
        itemBuilder: (context, index) {
          return PopularSearchCard(
            destination: recentSearches[index]['name'],
            image: recentSearches[index]['image'],
          );
        },
      ),
    );
  }
}

class PopularSearchCard extends StatelessWidget {
  final String destination;
  final String image;

  PopularSearchCard({required this.destination, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent.withOpacity(0.8),
              Colors.blueGrey.withOpacity(0.5)
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
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Image.asset(
                image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                destination,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
