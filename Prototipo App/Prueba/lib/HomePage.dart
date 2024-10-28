import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/ModeloEstado.dart';
import 'package:prueba2/PaginaBienvenida.dart';
import 'package:prueba2/PaginaOferta.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navegar a la misma página para refrescar
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Image.asset(
                'assets/logo.png', // Ruta de tu logo
                height: 30, // Reducir la altura del logo
              ),
            ),
            SizedBox(width: 10), // Espaciado entre el logo y el título
            Flexible(
              // Usar Flexible para el título
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
