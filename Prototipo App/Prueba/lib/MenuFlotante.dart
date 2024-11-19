import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prueba2/FormularioReserva.dart';
import 'package:prueba2/Mapa.dart';

class FloatingActionMenu extends StatefulWidget {
  @override
  _FloatingActionMenuState createState() => _FloatingActionMenuState();
}

class _FloatingActionMenuState extends State<FloatingActionMenu> {
  bool _isMenuOpen = false;

  void _handleReservation(
      String name, String phone, String date, int numPeople) {
    print("Reserva: $name, $phone, $date, $numPeople");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0, // Pegado a la esquina inferior
          right: 0, // Pegado a la esquina derecha
          child: AbsorbPointer(
            absorbing: !_isMenuOpen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _isMenuOpen ? 1.0 : 0.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationForm(
                                onSubmit: _handleReservation,
                              ),
                            ),
                          );
                        },
                        backgroundColor:
                            const Color.fromARGB(255, 89, 131, 230),
                        child: const Icon(Icons.bookmark_add),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.white,
                        child: Text(
                          'Realiza una reserva',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _isMenuOpen ? 1.0 : 0.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        onPressed: () async {
                          const String wazeUrl =
                              'https://www.waze.com/en/live-map/directions/co/tolima/ibague/mirador-tesorito?navigate=yes&place=ChIJRyUrGHXFOI4RXhgm1xeFUTU';

                          if (await canLaunch(wazeUrl)) {
                            await launch(wazeUrl); // Abre Waze en el navegador
                          } else {
                            throw 'No se pudo abrir Waze';
                          }
                        },
                        backgroundColor: const Color(0xFF88BDA4),
                        child: const Icon(Icons.location_on),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.white,
                        child: Text(
                          'Mapa',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isMenuOpen = !_isMenuOpen;
                    });
                  },
                  backgroundColor: const Color(0xFF88BDA4),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0, // Pegado a la esquina inferior
          right: 0, // Pegado a la esquina derecha
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _isMenuOpen = !_isMenuOpen;
              });
            },
            backgroundColor: const Color(0xFF88BDA4),
            child: _isMenuOpen ? Icon(Icons.close) : Icon(Icons.menu),
          ),
        ),
      ],
    );
  }
}
