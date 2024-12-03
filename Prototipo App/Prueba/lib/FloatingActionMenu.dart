import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prueba2/FormularioReserva.dart';

class FloatingActionMenu extends StatefulWidget {
  final String siteName; // Nombre del sitio turístico
  final String mapUrl; // URL del mapa para el sitio
  final VoidCallback onPressed;

  const FloatingActionMenu(
      {Key? key,
      required this.siteName,
      required this.mapUrl,
      required this.onPressed})
      : super(key: key);

  @override
  _FloatingActionMenuState createState() => _FloatingActionMenuState();
}

class _FloatingActionMenuState extends State<FloatingActionMenu> {
  bool _isMenuOpen = false; // Estado del menú (abierto/cerrado)

  // Método para abrir una URL
  void _openMap() async {
    if (await canLaunch(widget.mapUrl)) {
      await launch(widget.mapUrl); // Abre el mapa con la URL correspondiente
    } else {
      throw 'No se pudo abrir el mapa';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Botones del menú con IgnorePointer
        Positioned(
          bottom: 50,
          right: 0,
          child: IgnorePointer(
            ignoring: !_isMenuOpen, // Ignora eventos si el menú está cerrado
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isMenuOpen ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Botón para hacer una reserva
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationForm(
                                onSubmit: (name, phone, startDate, endDate,
                                    numPeople) {
                                  print(
                                      "Reserva: $name, $phone, Fecha de inicio: $startDate, Fecha de finalización: $endDate, Número de personas: $numPeople");
                                },
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
                        padding: const EdgeInsets.all(8),
                        color: Colors.white,
                        child: const Text(
                          'Realiza una reserva',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Botón para ver el mapa
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        onPressed: _openMap,
                        backgroundColor: Color.fromARGB(255, 92, 122, 108),
                        child: const Icon(Icons.map),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.white,
                        child: Text(
                          'Mapa: ${widget.siteName}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),

        // Botón principal para abrir/cerrar el menú
        Positioned(
          bottom: 0,
          right: 0,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _isMenuOpen = !_isMenuOpen;
              });
            },
            backgroundColor: Color.fromARGB(255, 78, 104, 91),
            child:
                _isMenuOpen ? const Icon(Icons.close) : const Icon(Icons.menu),
          ),
        ),
      ],
    );
  }
}
