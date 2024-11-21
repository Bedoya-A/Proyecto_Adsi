import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final List<Map<String, String>> _faqData = [
    {
      'question': '¿Cómo puedo realizar una reserva?',
      'answer':
          'Puedes hacer una reserva a través de nuestra página de "Reservas". Solo selecciona tu destino, fecha y confirma.',
    },
    {
      'question': '¿Puedo cancelar mi reserva?',
      'answer':
          'Sí, puedes cancelar tu reserva hasta 48 horas antes de la fecha de llegada sin cargo adicional.',
    },
    {
      'question': '¿Cómo puedo modificar mi itinerario?',
      'answer':
          'Para modificar tu itinerario, dirígete a la sección "Mis Reservas" y selecciona "Modificar".',
    },
    {
      'question': '¿Cuál es el horario de check-in y check-out?',
      'answer':
          'El check-in es a partir de las 2:00 PM, y el check-out debe realizarse antes de las 12:00 PM.',
    },
    {
      'question': '¿Hay opciones de transporte disponible?',
      'answer':
          'Sí, ofrecemos traslados al aeropuerto y al centro de la ciudad. Puedes reservarlo durante el proceso de reserva.',
    },
    {
      'question': '¿Cuáles son los destinos más populares?',
      'answer':
          'Algunos de nuestros destinos más populares son París, Roma, Nueva York, Tokio y Bali. ¡Explora más en nuestra sección de destinos!',
    },
    {
      'question': '¿Qué actividades puedo hacer en el destino?',
      'answer':
          'Dependiendo del destino, ofrecemos actividades como tours guiados, deportes acuáticos, y más. Consulta las actividades recomendadas en la página del destino.',
    },
    {
      'question': '¿Cómo puedo obtener un reembolso?',
      'answer':
          'Puedes solicitar un reembolso desde la sección "Mis Reservas". Si tienes dudas, contacta con nuestro soporte.',
    },
  ];

  List<Map<String, String>> _filteredFaqData = [];

  // Lista que almacena el estado de expansión de cada pregunta
  List<bool> _isExpandedList = List.generate(8, (_) => false);

  // Controlador del campo de búsqueda
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredFaqData = _faqData; // Inicialmente muestra todas las preguntas
  }

  // Función para filtrar las preguntas basadas en el texto de búsqueda
  void _searchFaq(String query) {
    final filtered = _faqData
        .where((faq) =>
            faq['question']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredFaqData = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preguntas Frecuentes - Turismo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E2A47),
              Color(0xFF3B4F88),
              Color(0xFF7A9FFF),
            ],
            stops: [0.2, 0.6, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Barra de búsqueda
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Buscar preguntas...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                  onChanged: (query) {
                    _searchFaq(query); // Actualizar los resultados al escribir
                  },
                ),
              ),
              // Lista de preguntas frecuentes filtradas
              Expanded(
                child: _filteredFaqData.isEmpty
                    ? Center(child: Text("No se encontraron resultados"))
                    : ListView.builder(
                        itemCount: _filteredFaqData.length,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isExpandedList[index] =
                                      !_isExpandedList[index];
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Column(
                                  children: [
                                    // Pregunta
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      color: Colors.deepPurpleAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              _filteredFaqData[index]
                                                  ['question']!,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            _isExpandedList[index]
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Respuesta
                                    AnimatedCrossFade(
                                      firstChild: Container(),
                                      secondChild: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          _filteredFaqData[index]['answer']!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      crossFadeState: _isExpandedList[index]
                                          ? CrossFadeState.showSecond
                                          : CrossFadeState.showFirst,
                                      duration:
                                          const Duration(milliseconds: 400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
