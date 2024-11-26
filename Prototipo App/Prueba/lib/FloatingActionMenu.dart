import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prueba2/FormularioReserva.dart';

class FloatingActionMenu extends StatefulWidget {
  final String siteName; // Nombre del sitio turístico
  final String mapUrl; // URL del mapa para el sitio

  const FloatingActionMenu({
    Key? key,
    required this.siteName,
    required this.mapUrl,
    required Null Function() onPressed,
  }) : super(key: key);

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
        Positioned(
          bottom: 0,
          right: 0,
          child: AbsorbPointer(
            absorbing: !_isMenuOpen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Botón para hacer una reserva
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isMenuOpen ? 1.0 : 0.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          // Acción de reserva
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
                ),
                const SizedBox(height: 8),

                // Botón para ver el mapa
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isMenuOpen ? 1.0 : 0.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        onPressed:
                            _openMap, // Llama a la función para abrir el mapa
                        backgroundColor: const Color(0xFF88BDA4),
                        child: const Icon(Icons.map),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.white,
                        child: Text(
                          'Mapa: ${widget.siteName}', // Muestra el nombre del sitio
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Botón para abrir/cerrar el menú
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isMenuOpen = !_isMenuOpen;
                    });
                  },
                  backgroundColor: Color.fromARGB(255, 98, 142, 122),
                  child: const Icon(Icons.close),
                ),
              ],
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
            backgroundColor: Color.fromARGB(255, 104, 139, 122),
            child:
                _isMenuOpen ? const Icon(Icons.close) : const Icon(Icons.menu),
          ),
        ),
      ],
    );
  }
}
