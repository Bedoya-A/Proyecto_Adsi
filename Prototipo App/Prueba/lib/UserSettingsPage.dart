import 'package:flutter/material.dart';

class UserMenuPage extends StatefulWidget {
  @override
  _UserMenuPageState createState() => _UserMenuPageState();
}

class _UserMenuPageState extends State<UserMenuPage> {
  bool isMenuOpen = false; // Controla la visibilidad del menú
  bool isDarkMode = false; // Controla el estado del modo oscuro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Página Principal',
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isMenuOpen = !isMenuOpen; // Alterna el menú
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/user_logo.png'), // Tu logo de usuario
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
              child: Text('Contenido de la página',
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black))),
          if (isMenuOpen)
            Positioned(
              right: 10,
              top: kToolbarHeight + 10,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: isDarkMode ? Colors.grey[850] : Colors.white,
                child: Container(
                  width: 250,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMenuOption('Mi Cuenta', Icons.account_circle),
                      _buildMenuOption(
                          'Inicio de sesión y seguridad', Icons.lock),
                      _buildMenuOption('Notificaciones', Icons.notifications),
                      _buildMenuOption('Idioma', Icons.language),
                      SwitchListTile(
                        title: Text(
                          'Modo Oscuro',
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                        value: isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = value; // Cambia el modo oscuro
                          });
                        },
                        secondary: Icon(Icons.dark_mode,
                            color: isDarkMode ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
      title: Text(title,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
      onTap: () {
        // Lógica para manejar el clic en las opciones
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Has seleccionado: $title')));
      },
    );
  }
}
