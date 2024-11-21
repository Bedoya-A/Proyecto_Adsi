import 'package:flutter/material.dart';

class UserMenu extends StatelessWidget {
  final VoidCallback onVerCuenta;
  final VoidCallback onActividad;
  final VoidCallback onSeguridad;
  final VoidCallback onNotificaciones;
  final VoidCallback onSoporte;
  final VoidCallback onCerrarSesion;

  UserMenu({
    required this.onVerCuenta,
    required this.onActividad,
    required this.onSeguridad,
    required this.onNotificaciones,
    required this.onSoporte,
    required this.onCerrarSesion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Ver mi cuenta'),
              onTap: onVerCuenta,
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Tu actividad'),
              onTap: onActividad,
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Acceso y seguridad'),
              onTap: onSeguridad,
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notificaciones'),
              onTap: onNotificaciones,
            ),
            ListTile(
              leading: Icon(Icons.support_agent),
              title: Text('Contactar con soporte técnico'),
              onTap: onSoporte,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: onCerrarSesion,
            ),
          ],
        ),
      ),
    );
  }
}
