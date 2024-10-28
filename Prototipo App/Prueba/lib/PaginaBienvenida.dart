import 'package:flutter/material.dart';

class PaginaBienvenida extends StatelessWidget {
  final VoidCallback onComenzar; // Callback para el botón

  const PaginaBienvenida({Key? key, required this.onComenzar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Image.asset(
              'assets/inicio.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(Icons.error,
                      color: Colors.red, size: 50), // Icono de error
                );
              },
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5), // Fondo semi-transparente
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
                      AnimatedOpacity(
                        opacity: 1.0,
                        duration: Duration(seconds: 1),
                        child: Text(
                          '¡Bienvenido a AppExplora Calambeo!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      AnimatedOpacity(
                        opacity: 1.0,
                        duration: Duration(seconds: 1),
                        child: Text(
                          'Esta aplicación está diseñada para ofrecerte una experiencia única explorando el corredor turístico Calambeo - Ambalá.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: onComenzar, // Llama al callback
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Color del botón
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Bordes redondeados
                          ),
                        ),
                        child: Text(
                          'Comenzar',
                          style: TextStyle(color: Colors.white),
                        ),
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
