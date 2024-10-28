import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/ModeloEstado.dart';
import 'package:prueba2/PaginaBienvenida.dart';
import 'package:prueba2/PaginaOferta.dart';

class HomePage extends StatefulWidget {
  // Cambiado a StatefulWidget
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isHomeIconVisible =
      false; // Agregado para manejar la visibilidad del ícono

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isHomeIconVisible =
                        !_isHomeIconVisible; // Cambia la visibilidad del ícono al hacer clic
                  });

                  // Espera a que la animación termine antes de navegar
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
                          size: 40, // Tamaño del ícono de inicio
                          color: Colors.white,
                        )
                      : CircleAvatar(
                          key: ValueKey('logoIcon'),
                          radius: 20, // Radio del logo
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                ),
              ),
            ),
            SizedBox(width: 10), // Espaciado entre el logo y el título
            Flexible(
              child: Text(
                'AppExplora Calambeo - Ambalá',
                overflow: TextOverflow.ellipsis, // Evitar overflow
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
                Scaffold.of(context)
                    .openEndDrawer(); // Abre el menú lateral a la derecha
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
      body: buildPageView(),
    );
  }

  Widget buildPageView() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        PageController _pageController =
            PageController(initialPage: appState.currentPage);

        return Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                appState.setCurrentPage(page);
              },
              children: [
                _buildPageTransition(
                    PaginaBienvenida(key: ValueKey(0))), // Transición
                _buildPageTransition(
                    PaginaOferta(key: ValueKey(1))), // Transición
              ],
            ),
            // Flecha izquierda para retroceder
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
            // Flecha derecha para avanzar
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
