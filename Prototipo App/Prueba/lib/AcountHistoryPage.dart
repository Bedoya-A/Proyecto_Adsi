import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AccountHistoryPage extends StatefulWidget {
  @override
  _AccountHistoryPageState createState() => _AccountHistoryPageState();
}

class _AccountHistoryPageState extends State<AccountHistoryPage> {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // Inicializar Firebase Messaging
    messaging.getToken().then((token) {
      print("Firebase Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Notificación recibida: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notificación abierta: ${message.notification?.title}');
    });
  }

  Future<void> shareContent() async {
    await FlutterShare.share(
      title: 'Descubre este increíble destino',
      text: '¡Mira este lugar impresionante! Visita nuestro sitio web.',
      linkUrl: 'https://tu-sitio-web.com/destino',
      chooserTitle: 'Compartir en redes sociales',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Cuenta'),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilterBar(),
            ),
            HistoryCard(
              destination: 'París',
              date: '12/11/2024',
              services: 'Vuelo + Alojamiento',
              imageUrl: 'https://example.com/image1.jpg',
            ),
            HistoryCard(
              destination: 'Tokyo',
              date: '05/10/2024',
              services: 'Alojamiento + Excursión',
              imageUrl: 'https://example.com/image2.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

class FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.date_range, color: Colors.white),
          label: Text("Filtrar por fecha"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Implementar acción de filtro por fecha
          },
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.location_on, color: Colors.white),
          label: Text("Filtrar por destino"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Implementar acción de filtro por destino
          },
        ),
      ],
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String destination;
  final String date;
  final String services;
  final String imageUrl;

  HistoryCard({
    required this.destination,
    required this.date,
    required this.services,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          // Implementar acción al hacer clic en la tarjeta
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.cyan.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                destination,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Fecha: $date',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Servicios: $services',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 8),
              // Galería de imágenes
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryPage(imageUrl: imageUrl),
                  ),
                ),
                child: Image.network(imageUrl,
                    width: double.infinity, height: 200, fit: BoxFit.cover),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => shareContent(),
                child: Text('Compartir Destino'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> shareContent() async {
    await FlutterShare.share(
      title: 'Descubre este increíble destino',
      text: '¡Mira este lugar impresionante! Visita [Nombre del Destino]',
      linkUrl: 'https://tu-sitio-web.com/destino',
      chooserTitle: 'Compartir en redes sociales',
    );
  }
}

class GalleryPage extends StatelessWidget {
  final String imageUrl;

  GalleryPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Galería de Imágenes"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: PhotoViewGallery.builder(
          itemCount: 1,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(imageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered,
            );
          },
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
          pageController: PageController(),
        ),
      ),
    );
  }
}
