import 'package:flutter/material.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/PaginaOfertaItems.dart';

class PaginaOferta extends StatelessWidget {
  const PaginaOferta({Key? key}) : super(key: key);

  void _openMenuSection(BuildContext context, int sectionIndex) {
    Scaffold.of(context).openEndDrawer();

    Future.delayed(Duration(milliseconds: 300), () {
      final menuState = context.findAncestorStateOfType<MenuState>();
      menuState
          ?.selectSection(sectionIndex); // Selecciona la sección específica
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/oferta.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(Icons.error, color: Colors.red, size: 50),
              );
            },
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.6),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Lo que te ofrecemos:',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      OfferItem(
                        offer: 'Miradores con vistas espectaculares',
                        icon: Icons.check_circle,
                        onTap: () => _openMenuSection(
                            context, 5), // Acción al hacer clic
                      ),
                      OfferItem(
                        offer: 'Cabañas acogedoras en plena naturaleza',
                        icon: Icons.check_circle,
                        onTap: () => _openMenuSection(
                            context, 1), // Acción al hacer clic
                      ),
                      OfferItem(
                        offer: 'Rutas de aventura y senderismo',
                        icon: Icons.check_circle,
                        onTap: () => _openMenuSection(
                            context, 7), // Acción al hacer clic
                      ),
                      OfferItem(
                        offer: 'Experiencias gastronómicas locales',
                        icon: Icons.check_circle,
                        onTap: () => _openMenuSection(
                            context, 10), // Acción al hacer clic
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
