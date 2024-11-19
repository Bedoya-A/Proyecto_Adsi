import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ContactSupportPage.dart';
import 'Menu.dart';
import 'MiCuentaPage.dart';
import 'ModeloEstado.dart';
import 'PaginaBienvenida.dart';
import 'PaginaOferta.dart';
import 'NotificacionesPage.dart';
import 'TuActividadPage.dart';
import 'AccesoSeguridadPage.dart'; // Importa la página de Acceso y Seguridad

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isHomeIconVisible = false;
  bool isMenuOpen = false;
  bool isDarkMode = false;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isHomeIconVisible = !_isHomeIconVisible;
                  });

                  Future.delayed(Duration(milliseconds: 350), () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  });
                },
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 350),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: _isHomeIconVisible
                      ? Icon(
                          Icons.home,
                          key: ValueKey('homeIcon'),
                          size: 40,
                          color: Colors.white,
                        )
                      : CircleAvatar(
                          key: ValueKey('logoIcon'),
                          radius: 20,
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                'AppExplora Calambeo - Ambalá',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Consumer<AppState>(
        builder: (context, appState, child) {
          return Menu(
            selectedDrawerIndex: appState.selectedDrawerIndex,
            onSelectDrawerItem: (index) {
              appState.setSelectedDrawerIndex(index);
            },
          );
        },
      ),
      body: Stack(
        children: [
          buildPageView(),
          if (isMenuOpen) _buildUserMenu(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isMenuOpen = !isMenuOpen;
          });
        },
        child: Icon(Icons.person, color: Colors.white),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget buildPageView() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                appState.setCurrentPage(page);
              },
              children: [
                _buildPageTransition(
                  PaginaBienvenida(
                    onComenzar: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      appState.setCurrentPage(1);
                    },
                  ),
                ),
                _buildPageTransition(
                  PaginaOferta(key: ValueKey(1)),
                ),
              ],
            ),
            if (appState.currentPage > 0)
              Positioned(
                left: 10,
                top: MediaQuery.of(context).size.height / 2 - 30,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    appState.setCurrentPage(appState.currentPage - 1);
                  },
                ),
              ),
            if (appState.currentPage < 1)
              Positioned(
                right: 10,
                top: MediaQuery.of(context).size.height / 2 - 30,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    appState.setCurrentPage(appState.currentPage + 1);
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPageTransition(Widget page) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: page,
    );
  }

  Widget _buildUserMenu() {
    return Positioned(
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
              _buildMenuOption('Mi Cuenta', Icons.account_circle, onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MiCuentaPage()),
                );
              }),
              _buildMenuOption('Tu Actividad', Icons.history, onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TuActividadPage()),
                );
              }),
              _buildMenuOption('Acceso y seguridad', Icons.lock, onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Accesoseguridadpage()),
                );
              }),
              _buildMenuOption('Notificaciones', Icons.notifications,
                  onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificacionesPage()),
                );
              }),
              _buildMenuOption('Idioma', Icons.language),
              _buildMenuOption(
                'Contactar con soporte técnico',
                Icons.support_agent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactSupportPage()),
                  );
                },
              ),
              SwitchListTile(
                title: Text(
                  'Modo Oscuro',
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                ),
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
                secondary: Icon(Icons.dark_mode,
                    color: isDarkMode ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption(String title, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
      title: Text(
        title,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      ),
      onTap: onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Has seleccionado: $title')));
          },
    );
  }
}
