import 'package:flutter/material.dart';

class LinkHistoryPage extends StatelessWidget {
  final List<Map<String, String>> linkHistory = [
    {
      'title': 'Parque Temático Meraki',
      'url': 'https://www.meraki.com',
      'icon': 'assets/meraki_icon.png'
    },
    {
      'title': 'Mirador Tesorito',
      'url': 'https://www.tesorito.com',
      'icon': 'assets/tesorito_icon.png'
    },
    {
      'title': 'Auctotonos',
      'url': 'https://www.auctotonos.com',
      'icon': 'assets/auctotonos_icon.png'
    },
    {
      'title': 'Jardín Botánico',
      'url': 'https://www.jardinbotanico.com',
      'icon': 'assets/jardin_botanico_icon.png'
    },
    {
      'title': 'Paraíso Escondido',
      'url': 'https://www.paraiso.com',
      'icon': 'assets/paraiso_icon.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Enlaces'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever, color: Colors.redAccent),
            onPressed: () {
              // Función para eliminar todo el historial de enlaces
              print('Se ha borrado todo el historial de enlaces');
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
                'Enlaces Visitados',
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
              LinkHistoryList(linkHistory: linkHistory),
            ],
          ),
        ),
      ),
    );
  }
}

class LinkHistoryList extends StatelessWidget {
  final List<Map<String, String>> linkHistory;

  LinkHistoryList({required this.linkHistory});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: linkHistory.length,
      itemBuilder: (context, index) {
        return LinkHistoryCard(
          title: linkHistory[index]['title']!,
          url: linkHistory[index]['url']!,
          icon: linkHistory[index]['icon']!,
        );
      },
    );
  }
}

class LinkHistoryCard extends StatelessWidget {
  final String title;
  final String url;
  final String icon;

  LinkHistoryCard({required this.title, required this.url, required this.icon});

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
                icon,
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
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    url,
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
                // Función de eliminar enlace
                print('Enlace eliminado: $title');
              },
            ),
          ],
        ),
      ),
    );
  }
}
