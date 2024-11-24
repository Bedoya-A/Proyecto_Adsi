import 'package:flutter/material.dart';

class AccountHistoryPage extends StatelessWidget {
  // Lista de notificaciones o elementos demostrativos
  final List<Map<String, String>> notifications = [
    {
      'title': '¡Nueva oferta en París!',
      'body': 'Disfruta de un descuento del 20% en tu próxima compra en París.'
    },
    {
      'title': 'Tu vuelo a Tokyo ha sido confirmado',
      'body': '¡Recuerda llegar al aeropuerto con 2 horas de antelación!'
    },
    {
      'title': 'Revisa tus reservas de hotel',
      'body': 'Tienes 3 reservas de hotel pendientes por confirmar.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificaciones Demo"),
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(
              notification['title']!,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.cyanAccent),
            ),
            subtitle: Text(
              notification['body']!,
              style: TextStyle(color: Colors.white70),
            ),
            tileColor: Colors.blueAccent.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}
