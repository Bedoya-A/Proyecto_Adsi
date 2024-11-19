import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home:
          NotificacionesPage(), // La página de notificaciones como página inicial
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
  final List<String> notifications = [
    "¡Nuevo destino! Descubre Cartagena.",
    "20% OFF en tours a Medellín.",
    "Reserva tu tour al Amazonas ahora.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Notificaciones Futuristas'),
        backgroundColor: Colors.redAccent,
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
      body: Center(
        child: Text(
          'Bienvenido a la página de turismo',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      // Panel de notificaciones flotante
      floatingActionButton: isNotificationVisible
          ? NotificationPanel(notifications: notifications)
          : SizedBox.shrink(),
    );
  }
}

class NotificationPanel extends StatelessWidget {
  final List<String> notifications;

  NotificationPanel({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: notifications.length * 70.0, // Menos espacio, más compacto
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              offset: Offset(0, -5),
              blurRadius: 10,
            ),
          ],
        ),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return NotificationItem(notification: notifications[index]);
          },
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String notification;

  NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.redAccent, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.notifications, color: Colors.redAccent, size: 28),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              notification,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
