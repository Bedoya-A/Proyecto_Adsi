import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/FloatingActionMenu.dart';
import 'package:url_launcher/url_launcher.dart';

class CabanaEncanto extends StatefulWidget {
  const CabanaEncanto({super.key});

  @override
  _CabanaEncantoState createState() => _CabanaEncantoState();
}

class _CabanaEncantoState extends State<CabanaEncanto> {
  int selectedDrawerIndex = 1;

  double _rating = 0; // Initial rating value
  TextEditingController _reviewController = TextEditingController();

  // List to store reviews
  List<Map<String, dynamic>> _reviews = [];

  final List<String> imgList = [
    'assets/encanto1.png',
    'assets/encanto2.png',
    'assets/encanto3.png',
    'assets/encanto4.png',
    'assets/encanto5.png',
  ];
  int _current = 0;

  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
  }

  Future<void> _openMap() async {
    const url =
        'https://maps.app.goo.gl/47jiTafrHd3NBNKN9'; // Reemplaza con la URL de tu ubicación
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el mapa: $url';
    }
  }

  Future<void> _launchYoutube() async {
    const url = 'https://youtu.be/ev2h6MBlMhM';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = index + 1.0;
            });
          },
          child: Icon(
            Icons.star,
            color: _rating > index ? Colors.amber : Colors.grey,
            size: 30,
          ),
        );
      }),
    );
  }

  void _removeReview(int index) {
    setState(() {
      _reviews.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cabaña el Encanto', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icono para retroceder
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context)
                    .openEndDrawer(); // Open the right-side menu
              },
            ),
          ),
        ],
      ),
      endDrawer: Menu(
        selectedDrawerIndex: selectedDrawerIndex,
        onSelectDrawerItem: onSelectDrawerItem,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 153, 255, 204), Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Imagen destacada
                Image.asset(
                  'assets/cabañaencanto.jpg', // Cambia por la imagen adecuada
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),

                // Sección de características
                _buildSectionCard(
                  "Características",
                  Icons.star,
                  _buildFeatureList(),
                ),

                // Slider de imágenes
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CarouselSlider(
                      items: imgList.map((item) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(item,
                                fit: BoxFit.cover, width: 1000),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.33,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _current = (_current - 1) % imgList.length;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: IconButton(
                        icon:
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _current = (_current + 1) % imgList.length;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Botón para ver el video (debajo del carousel)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: _launchYoutube,
                      icon: Icon(
                        Icons.video_library,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      label: Text(
                        "Ver video en YouTube",
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(
                            255, 101, 161, 154), // Color del botón
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Secciones adicionales
                _buildSectionCard("Precios", Icons.money, _buildPriceList()),
                _buildSectionCard(
                    "Senderismo", Icons.hiking, _buildHikingText()),
                _buildSectionCard(
                    "Parqueadero", Icons.local_parking, _buildParkingText()),
                _buildSectionCard(
                    "Ingreso", Icons.access_time, _buildIngresoText()),
                _buildSectionCard(
                    "Salida", Icons.exit_to_app, _buildSalidaText()),
                _buildSectionTitle("DEJA TU RESEÑA", Icons.star_rate),
                SizedBox(height: 20),
                _buildStarRating(),
                SizedBox(height: 20),
                TextField(
                  controller: _reviewController,
                  decoration: InputDecoration(
                    labelText: 'Escribe tu reseña',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _reviews.add({
                        'rating': _rating,
                        'review': _reviewController.text,
                      });
                      _reviewController.clear();
                    });
                  },
                  child: Text('Enviar Reseña'),
                ),
                SizedBox(height: 20),
                // Mostrar las reseñas con opción de eliminar
                Column(
                  children: _reviews.map((review) {
                    int index = _reviews.indexOf(review);
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 5),
                            Text('${review['rating']} estrellas'),
                          ],
                        ),
                        subtitle: Text(review['review']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              _removeReview(index), // Eliminar reseña
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionMenu(
        siteName: "Cabaña el Encanto", // Nombre del sitio
        mapUrl:
            "https://maps.app.goo.gl/47jiTafrHd3NBNKN9", // URL del mapa (Waze o Google Maps)
        onPressed: () {
          _openMap(); // Acción al presionar el botón para abrir el mapa
        },
      ),
    );
  }

  // Widget para los títulos con icono, fondo de degradado y tarjeta
  Widget _buildSectionCard(String title, IconData icon, Widget content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: content,
          ),
        ],
      ),
    );
  }

  // Widget para la lista de características con iconos
  Widget _buildFeatureList() {
    const List<Map<String, dynamic>> features = [
      {'text': 'Hospedaje 1 noche para 1 o 2 parejas', 'icon': Icons.bed},
      {'text': 'Río y cascada', 'icon': Icons.water},
      {'text': 'La mejor vista de Ibagué', 'icon': Icons.landscape},
      {'text': 'WiFi', 'icon': Icons.wifi},
      {'text': 'TV', 'icon': Icons.tv},
      {'text': 'Nevera y cocina', 'icon': Icons.kitchen},
      {'text': 'Piscina pequeña', 'icon': Icons.pool},
      {'text': 'Baño y ducha', 'icon': Icons.bathroom},
      {'text': 'Cabina Bluetooth', 'icon': Icons.speaker},
      {'text': 'Asador grande', 'icon': Icons.outdoor_grill},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Icon(feature['icon'] as IconData, color: Colors.brown[600]),
              const SizedBox(width: 8),
              Expanded(
                // Envuelve el Text con Expanded
                child: Text(
                  feature['text'] as String,
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow
                      .ellipsis, // Agregar truncamiento si el texto es demasiado largo
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Widget para la lista de precios
  Widget _buildPriceList() {
    const List<String> prices = [
      'Cabaña para 1 noche: \$100.000',
      'Cabaña para 2 noches: \$180.000',
      'Cabaña para 3 noches: \$250.000',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: prices.map((price) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(price, style: const TextStyle(fontSize: 16)),
        );
      }).toList(),
    );
  }

  // Widget para el senderismo
  Widget _buildHikingText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "De la entrada hasta la cabaña son 10 minutos de senderismo (400 metros)."),
        const SizedBox(height: 10),
        Text(
          "En la entrada te reciben, llevan y entregan la cabaña.",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Widget para el parqueadero
  Widget _buildParkingText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " moto a \$8.000 y carro a \$12.000.",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Widget para el ingreso
  Widget _buildIngresoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "El ingreso a la cabaña es a partir de las 2:00 PM. Si llegas más temprano, puedes esperar en la entrada o en la zona común.",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Widget para la salida
  Widget _buildSalidaText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "La salida es a las 12:00 PM. Si necesitas un poco más de tiempo, puedes pedirlo con anticipación.",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orangeAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.white),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
