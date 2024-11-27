import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LinkHistoryPage extends StatefulWidget {
  @override
  _LinkHistoryPageState createState() => _LinkHistoryPageState();
}

class _LinkHistoryPageState extends State<LinkHistoryPage> {
  List<Map<String, dynamic>> linkHistory = [
    {
      'title': 'Parque Temático Meraki',
      'url': 'https://www.meraki.com',
      'icon': 'assets/meraki5.png',
      'category': 'Turismo',
      'favorite': false,
      'description': 'Un parque con experiencias inolvidables para todos.'
    },
    {
      'title': 'Mirador Tesorito',
      'url': 'https://www.tesorito.com',
      'icon': 'assets/tesorito5.jpg',
      'category': 'Turismo',
      'favorite': false,
      'description': 'Vistas espectaculares de la naturaleza desde lo alto.'
    },
    {
      'title': 'Auctotonos',
      'url': 'https://www.auctotonos.com',
      'icon': 'assets/autoctonos2.jpg',
      'category': 'Cultura',
      'favorite': false,
      'description': 'Un viaje virtual por la historia de la cultura local.'
    },
    {
      'title': 'Jardín Botánico',
      'url': 'https://www.jardinbotanico.com',
      'icon': 'assets/aves.jpg',
      'category': 'Naturaleza',
      'favorite': false,
      'description':
          'Un refugio de paz y belleza natural en medio de la ciudad.'
    },
    {
      'title': 'Paraíso Escondido',
      'url': 'https://www.paraiso.com',
      'icon': 'assets/montaña5.png',
      'category': 'Turismo',
      'favorite': false,
      'description': 'Descubre un paraíso oculto en un destino único.'
    },
  ];

  String selectedCategory = 'Todos';

  void _deleteLink(int index) {
    setState(() {
      linkHistory.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredLinks = selectedCategory == 'Todos'
        ? linkHistory
        : linkHistory
            .where((link) => link['category'] == selectedCategory)
            .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.link, color: Colors.cyanAccent, size: 30),
            SizedBox(width: 10),
            Text(
              'Historial de Enlaces',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMainTitle(), // Título principal
            SizedBox(height: 20),
            _buildImageCarousel(), // Carrusel de imágenes debajo del título
            SizedBox(height: 20),
            _buildMainDescription(), // Descripción principal
            SizedBox(height: 20),
            _buildStatistics(), // Estadísticas
            SizedBox(height: 20),
            _buildCategorySelector(), // Selector de categorías
            SizedBox(height: 20),
            filteredLinks.isNotEmpty
                ? LinkHistoryList(
                    linkHistory: filteredLinks,
                    onToggleFavorite: (index) {
                      setState(() {
                        filteredLinks[index]['favorite'] =
                            !filteredLinks[index]['favorite'];
                      });
                    },
                    onDelete: _deleteLink,
                  )
                : Center(
                    child: Text(
                      'No se encontraron enlaces en esta categoría.',
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // Carrusel de imágenes
  Widget _buildImageCarousel() {
    final List<String> images = [
      'assets/meraki5.png',
      'assets/tesorito5.jpg',
      'assets/autoctonos2.jpg',
      'assets/eventos.jpg',
      'assets/cabañaencanto.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  // Título principal
  Widget _buildMainTitle() {
    return Center(
      child: AnimatedDefaultTextStyle(
        duration: Duration(milliseconds: 600),
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.cyanAccent,
          letterSpacing: 2,
          shadows: [
            Shadow(
              color: Colors.blueAccent,
              offset: Offset(0, 2),
              blurRadius: 5,
            )
          ],
        ),
        child: Text('Bienvenido a tu Historial de Enlaces'),
      ),
    );
  }

  // Descripción principal
  Widget _buildMainDescription() {
    return Text(
      'Explora, administra y guarda tus enlaces favoritos de una manera sencilla y divertida. ¡Nunca más perderás un enlace importante!',
      style: TextStyle(
        fontSize: 18,
        color: Colors.white70,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  // Estadísticas
  Widget _buildStatistics() {
    int totalLinks = linkHistory.length;
    int totalFavorites =
        linkHistory.where((link) => link['favorite'] == true).length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard('Total Enlaces', totalLinks.toString(), Icons.link),
        _buildStatCard('Favoritos', totalFavorites.toString(), Icons.favorite),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, color: Colors.cyanAccent, size: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                value,
                style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Selector de categorías
  Widget _buildCategorySelector() {
    List<String> categories = ['Todos', 'Turismo', 'Cultura', 'Naturaleza'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: selectedCategory == category
                    ? Colors.cyanAccent
                    : Colors.grey[850],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: selectedCategory == category
                      ? Colors.black
                      : Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class LinkHistoryList extends StatelessWidget {
  final List<Map<String, dynamic>> linkHistory;
  final Function(int) onToggleFavorite;
  final Function(int) onDelete;

  LinkHistoryList({
    required this.linkHistory,
    required this.onToggleFavorite,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: linkHistory.length,
      itemBuilder: (context, index) {
        final link = linkHistory[index];
        return Card(
          color: Colors.grey[900],
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(link['icon']),
            ),
            title: Text(
              link['title'],
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              link['description'],
              style: TextStyle(color: Colors.white70),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    link['favorite'] ? Icons.favorite : Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                  onPressed: () => onToggleFavorite(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
