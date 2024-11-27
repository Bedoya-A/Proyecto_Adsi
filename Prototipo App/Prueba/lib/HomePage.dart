import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/AccesoSeguridadPage.dart';
import 'package:prueba2/ContactSupportPage.dart';
import 'package:prueba2/CustomAppbar.dart';
import 'package:prueba2/InicioSesion.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/MenuUsuario.dart';
import 'package:prueba2/MiCuentaPage.dart';
import 'package:prueba2/ModeloEstado.dart';
import 'package:prueba2/PaginaBienvenida.dart';
import 'package:prueba2/PaginaOferta.dart';
import 'package:prueba2/RegistroSesion.dart';
import 'package:prueba2/TuActividadPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        bool isDarkMode = appState.themeMode == ThemeMode.dark;
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              isLoggedIn: appState.isLoggedIn,
              profileImageUrl: appState.isLoggedIn ? 'url-a-imagen' : null,
              onUserIconPressed:
                  appState.isLoggedIn ? _showUserMenu : _showLoginOrRegister,
              onMenuPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
          endDrawer: Menu(
            selectedDrawerIndex: appState.selectedDrawerIndex,
            onSelectDrawerItem: (index) {
              appState.setSelectedDrawerIndex(index);
            },
          ),
          body: Stack(
            children: [
              buildPageView(),
            ],
          ),
        );
      },
    );
  }

  void _showLoginOrRegister() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Iniciar sesión'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.app_registration),
                title: Text('Registrar cuenta'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUserMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return UserMenuContent(
          onVerCuenta: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MiCuentaPage()),
            );
          },
          onActividad: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TuActividadPage()),
            );
          },
          onSeguridad: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccesoSeguridadPage()),
            );
          },
          onSoporte: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactSupportPage()),
            );
          },
          onCerrarSesion: _logout,
        );
      },
    );
  }

  void _logout() {
    Provider.of<AppState>(context, listen: false).setLoginStatus(false);
    Navigator.pop(context); // Cierra el menú modal
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
                _buildPageTransition(PaginaBienvenida(
                  onComenzar: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    appState.setCurrentPage(1);
                  },
                )),
                _buildPageTransition(PaginaOferta(key: ValueKey(1))),
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
}
