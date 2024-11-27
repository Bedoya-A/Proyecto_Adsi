import 'package:flutter/material.dart';

class UserMenuContent extends StatelessWidget {
  final VoidCallback onVerCuenta;
  final VoidCallback onActividad;
  final VoidCallback onSeguridad;
  final VoidCallback onSoporte;
  final VoidCallback onCerrarSesion;

  UserMenuContent({
    required this.onVerCuenta,
    required this.onActividad,
    required this.onSeguridad,
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
          children: [
            _buildMenuItem(Icons.account_circle, 'Ver cuenta', onVerCuenta),
            _buildMenuItem(Icons.access_alarm, 'Actividad', onActividad),
            _buildMenuItem(Icons.security, 'Seguridad', onSeguridad),
            _buildMenuItem(Icons.headset_mic, 'Soporte', onSoporte),
            _buildMenuItem(Icons.exit_to_app, 'Cerrar sesión', onCerrarSesion),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
