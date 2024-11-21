import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: NotificacionesPage(),
    );
  }
}

class NotificacionesPage extends StatefulWidget {
  @override
  _NotificacionesPageState createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  bool isNotificationVisible = false;

  // Notificaciones de ejemplo
  final List<Map<String, String>> notifications = [
    {
      "message": "¡Nuevo destino! Descubre Cartagena.",
      "image": "assets/cartagena.jpg"
    },
    {"message": "20% OFF en tours a Medellín.", "image": "assets/medellin.jpg"},
    {
      "message": "Reserva tu tour al Amazonas ahora.",
      "image": "assets/amazonas.jpg"
    },
  ];

  // Carrusel de imágenes (destinos turísticos)
  final List<String> carouselImages = [
    'assets/meraki4.png',
    'assets/senderismo.jpg',
    'assets/tesorito5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones Futuristas'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              setState(() {
                isNotificationVisible = !isNotificationVisible;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fondo dinámico con gradiente
          AnimatedContainer(
            duration: Duration(seconds: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purple, Colors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                // Carrusel de imágenes
                Container(
                  height: 250,
                  child: PageView.builder(
                    itemCount: carouselImages.length,
                    controller: PageController(viewportFraction: 0.85),
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // Imagen de fondo con desenfoque
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              carouselImages[index],
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                            ),
                          ),
                          // Fondo desenfocado
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          // Texto sobre la imagen
                          AnimatedOpacity(
                            opacity: 1.0,
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              "Explora nuevos destinos",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(5.0, 5.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // Texto descriptivo adicional
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Descubre más sobre los mejores destinos turísticos del mundo.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Panel de notificaciones flotante
          if (isNotificationVisible)
            NotificationPanel(notifications: notifications),
        ],
      ),
    );
  }
}

class NotificationPanel extends StatelessWidget {
  final List<Map<String, String>> notifications;

  NotificationPanel({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        height: notifications.length * 150.0,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              offset: Offset(0, -5),
              blurRadius: 20,
            ),
          ],
        ),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return NotificationItem(
              notification: notifications[index]['message']!,
              image: notifications[index]['image']!,
            );
          },
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String notification;
  final String image;

  NotificationItem({required this.notification, required this.image});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              notification,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 18,
          ),
        ],
      ),
    );
  }
}
