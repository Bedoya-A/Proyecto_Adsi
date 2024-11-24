import 'package:flutter/material.dart';

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
        title: Row(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Título principal con animación
              _buildMainTitle(),

              SizedBox(height: 20),

              // Descripción destacada
              _buildMainDescription(),

              SizedBox(height: 20),

              // Estadísticas
              _buildStatistics(),

              SizedBox(height: 20),

              // Selector de Categorías
              _buildCategorySelector(),

              SizedBox(height: 20),

              // Lista de Enlaces
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
      ),
    );
  }

  // Título principal llamativo
  Widget _buildMainTitle() {
    return AnimatedDefaultTextStyle(
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
    );
  }

  // Descripción llamativa debajo del título
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

  // Estadísticas (Total Enlaces y Favoritos)
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

  // Selector de Categorías
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
                      : Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
  final Function(int index) onToggleFavorite;
  final Function(int index) onDelete;

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
        return LinkHistoryCard(
          title: linkHistory[index]['title']!,
          url: linkHistory[index]['url']!,
          icon: linkHistory[index]['icon']!,
          description: linkHistory[index]['description']!,
          isFavorite: linkHistory[index]['favorite'],
          onToggleFavorite: () => onToggleFavorite(index),
          onDelete: () => onDelete(index),
        );
      },
    );
  }
}

class LinkHistoryCard extends StatelessWidget {
  final String title;
  final String url;
  final String icon;
  final String description;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onDelete;

  LinkHistoryCard({
    required this.title,
    required this.url,
    required this.icon,
    required this.description,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                icon,
                width: 80, // Imagen más grande
                height: 80, // Imagen más grande
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),

            // Título y descripción
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Corazón y eliminar
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white70,
                  ),
                  onPressed: onToggleFavorite,
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: onDelete,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
