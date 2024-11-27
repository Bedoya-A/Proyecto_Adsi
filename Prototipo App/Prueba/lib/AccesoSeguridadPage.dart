import 'package:flutter/material.dart';

class AccessAndSecurityScreen extends StatefulWidget {
  const AccessAndSecurityScreen({super.key});

  @override
  _AccessAndSecurityScreenState createState() =>
      _AccessAndSecurityScreenState();
}

class _AccessAndSecurityScreenState extends State<AccessAndSecurityScreen> {
  bool _isTwoFactorEnabled = false; // Estado del Toggle de 2FA
  bool _isBiometricEnabled = false; // Estado del Toggle de Biometría
  bool _isNotificationEnabled = false; // Notificaciones de seguridad

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context), // Volver sin parpadeo
          ),
          title: const Text('Acceso y Seguridad'),
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 10,
          shadowColor: Colors.deepPurple.withOpacity(0.5),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título de la página
                Text(
                  'Gestión de Acceso y Seguridad',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 6,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Descripción
                Text(
                  'Administra la seguridad de tu cuenta activando opciones como verificación en dos pasos, autenticación biométrica y más.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 20),

                // Sección de inicio de sesión
                _buildSectionTitle('Inicia sesión'),
                const SizedBox(height: 10),
                _buildCard(
                  icon: Icons.lock,
                  title: 'Contraseña',
                  description:
                      'Para agregar una contraseña a tu cuenta, utiliza la página para restablecer la contraseña.',
                  actionText: 'Restablecer contraseña',
                  onPressed: () {},
                ),
                const SizedBox(height: 20),

                // Sección de seguridad
                _buildSectionTitle('Seguridad'),
                const SizedBox(height: 10),
                _buildCard(
                  icon: Icons.logout,
                  title: 'Cerrar sesión en todos los dispositivos',
                  description:
                      '¿Iniciaste sesión desde un dispositivo compartido? No hay problema, cierra sesión en todos tus dispositivos.',
                  actionText: 'Cerrar sesión en todos los dispositivos',
                  onPressed: () {},
                ),
                const SizedBox(height: 20),

                // Sección de descarga de archivos
                _buildSectionTitle('Descargar archivos'),
                const SizedBox(height: 10),
                _buildCard(
                  icon: Icons.download,
                  title: 'Descarga tus archivos y diseños',
                  description:
                      'Descarga tus archivos directamente desde la plataforma.',
                  actionText: 'Solicitud de descarga',
                  onPressed: () {},
                ),
                const SizedBox(height: 20),

                // Sección de Verificación en dos pasos
                _buildSectionTitle('Verificación en Dos Pasos'),
                const SizedBox(height: 10),
                _buildCardWithToggle(
                  icon: Icons.security,
                  title: 'Activar verificación en dos pasos',
                  description:
                      'Agrega una capa adicional de seguridad activando la verificación en dos pasos.',
                  toggleValue: _isTwoFactorEnabled,
                  onToggle: (bool value) {
                    setState(() {
                      _isTwoFactorEnabled = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Sección de Autenticación Biométrica
                _buildSectionTitle('Autenticación Biométrica'),
                const SizedBox(height: 10),
                _buildCardWithToggle(
                  icon: Icons.fingerprint,
                  title: 'Habilitar huella dactilar',
                  description:
                      'Accede más rápido utilizando tu huella dactilar.',
                  toggleValue: _isBiometricEnabled,
                  onToggle: (bool value) {
                    setState(() {
                      _isBiometricEnabled = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Sección de Historial de Inicios de sesión
                _buildSectionTitle('Historial de Inicios de Sesión'),
                const SizedBox(height: 10),
                _buildCard(
                  icon: Icons.history,
                  title: 'Verificar historial de inicios de sesión',
                  description:
                      'Revisa los inicios de sesión y dispositivos conectados.',
                  actionText: 'Ver historial',
                  onPressed: () {},
                ),
                const SizedBox(height: 20),

                // Sección de Notificaciones de Seguridad
                _buildSectionTitle('Notificaciones de Seguridad'),
                const SizedBox(height: 10),
                _buildCardWithToggle(
                  icon: Icons.notifications,
                  title: 'Activar notificaciones de seguridad',
                  description:
                      'Recibe notificaciones en caso de actividad sospechosa.',
                  toggleValue: _isNotificationEnabled,
                  onToggle: (bool value) {
                    setState(() {
                      _isNotificationEnabled = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurpleAccent,
        shadows: [
          Shadow(
            offset: Offset(0, 2),
            blurRadius: 6,
            color: Colors.white.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
    required String actionText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 25,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.deepPurpleAccent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(color: Colors.grey[400]),
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
            onPressed: onPressed,
            child: Text(actionText),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWithToggle({
    required IconData icon,
    required String title,
    required String description,
    required bool toggleValue,
    required ValueChanged<bool> onToggle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 25,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.deepPurpleAccent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(color: Colors.grey[400]),
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            value: toggleValue,
            onChanged: onToggle,
            title: Text(
              toggleValue ? 'Activado' : 'Desactivado',
              style: TextStyle(
                color: toggleValue ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            tileColor: Colors.deepPurple.withOpacity(0.1),
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
