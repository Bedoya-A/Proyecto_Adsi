import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/FloatingActionMenu.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa tu HomePage para la navegación

class CabanaDelArbol extends StatefulWidget {
  @override
  _CabanaDelArbolState createState() => _CabanaDelArbolState();
}

class _CabanaDelArbolState extends State<CabanaDelArbol> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int selectedDrawerIndex = 1;

  double _rating = 0; // Initial rating value
  TextEditingController _reviewController = TextEditingController();

  // List to store reviews
  List<Map<String, dynamic>> _reviews = [];

  final List<String> imgList = [
    'assets/arbol1.png',
    'assets/arbol2.png',
    'assets/arbol3.png',
    'assets/arbol4.png',
    'assets/arbol5.png',
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

  // Build the star rating
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

  // Function to remove review
  void _removeReview(int index) {
    setState(() {
      _reviews.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cabaña del árbol', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff8B4513),
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
        color: Color(0xffD2B48C),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Imagen destacada
                      Image.asset(
                        'assets/cabañaarbol.jpg', // Cambia por la imagen adecuada
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),

                      // Descripción
                      Text(
                        'Un encantador refugio suspendido entre las ramas, donde podrás disfrutar de una experiencia única en contacto directo con la naturaleza. '
                        'Despierta con el sonido de los pájaros, relájate con vistas inigualables y vive la magia de un retiro perfecto en lo alto. ¡Una escapada que te hará sentir como en un cuento!',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),

                      // Servicios
                      Text(
                        ' SERVICIOS ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2e8b57),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),

                      Column(
                        children: [
                          servicioTarjeta(
                              Icons.bed, 'Cama Queen muy cómoda', 14),
                          servicioTarjeta(
                              Icons.visibility, 'Avistamiento de aves', 14),
                          servicioTarjeta(Icons.water, 'Río y cascada', 14),
                          servicioTarjeta(Icons.restaurant_menu, 'Asador', 14),
                          servicioTarjeta(Icons.bathtub, 'Baño y ducha', 14),
                          servicioTarjeta(
                              Icons.wine_bar, 'Copas, vasos, platos', 14),
                          servicioTarjeta(
                              Icons.terrain, 'Hamaca y terraza', 14),
                          servicioTarjeta(Icons.games, 'Juegos de mesa', 14),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CarouselSlider(
                            items: imgList
                                .map((item) => Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(item,
                                            fit: BoxFit.cover, width: 1000),
                                      ),
                                    ))
                                .toList(),
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
                              icon: Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
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
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _current = (_current + 1) % imgList.length;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      // Botón para ver el video
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: _launchYoutube,
                            icon: Icon(Icons.video_library,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                            label: Text(
                              "Ver video en YouTube",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                  255, 101, 161, 154), // Color del botón
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Estamos a 10 minutos de la Universidad de Ibagué en el barrio Ambalá. '
                                  'Puedes llegar en Uber, moto o carro hasta la entrada del lugar. Puedes llevar toda la comida y bebida que desees, nosotros no vendemos.',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, // Cambiar a start
                                  children: [
                                    Icon(Icons.directions_walk,
                                        color: Color(0xffd2b48c)),
                                    SizedBox(width: 8),
                                    Expanded(
                                      // Añadir Expanded para evitar overflow
                                      child: Text(
                                        '20 minutos de senderismo (800m)',
                                        style: TextStyle(fontSize: 16),
                                        overflow: TextOverflow
                                            .ellipsis, // Añadir truncamiento si el texto es largo
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Precios en una tarjeta
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.attach_money,
                                      color: Color(0xffd2b48c), size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    'PRECIOS:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff2e8b57),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  precioItem('Lunes a Jueves', '150.000',
                                      Color(0xff2e8b57)),
                                  precioItem('Viernes o Domingos', '200.000',
                                      Color(0xff2e8b57)),
                                  precioItem('Sábados o día antes de festivo',
                                      '250.000', Colors.green[800]!),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Información de senderismo en tarjeta
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(Icons.directions_walk,
                                  color: Color(0xffd2b48c), size: 24),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SENDERISMO:',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff2e8b57),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '20 minutos de senderismo (800m)',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Información adicional de parqueadero en tarjeta
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(Icons.local_parking,
                                  color: Color(0xffd2b48c), size: 24),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'PARQUEADERO:',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff2E8B57),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Parqueadero gratuito.',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      _buildReviewForm(context)
                    ]))),
      ),
      floatingActionButton: FloatingActionMenu(
        siteName: "Cabaña del Arbol", // Nombre del sitio
        mapUrl:
            "https://maps.app.goo.gl/47jiTafrHd3NBNKN9", // URL del mapa (Waze o Google Maps)
        onPressed: () {
          _openMap(); // Acción al presionar el botón para abrir el mapa
        },
      ),
    );
  }

  Widget servicioTarjeta(IconData icon, String servicio, double size) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Color(0xffd2b48c)),
        title: Text(servicio, style: TextStyle(fontSize: size)),
      ),
    );
  }

  Widget precioItem(String dia, String precio, Color color) {
    return ListTile(
      title: Text(dia),
      trailing: Text(
        '\$$precio',
        style: TextStyle(fontSize: 20, color: color),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xff2E8B57),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            // Envuelve el texto con Expanded
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
              overflow: TextOverflow.ellipsis, // Añadir puntos suspensivos
              maxLines: 1, // Limitar a una línea
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewForm(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30), // Espaciado adicional
              // Sección de reseñas
              _buildSectionTitle("DEJA TU RESEÑA", Icons.star_rate),
              SizedBox(height: 20), // Separación adicional
              _buildStarRating(),
              SizedBox(height: 20), // Separación adicional
              TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  labelText: 'Escribe tu reseña',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
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
              ),
              SizedBox(height: 20),
              // Mostrar las reseñas con opción de eliminar
              Column(
                children: _reviews.map((review) {
                  int index = _reviews.indexOf(review); // Obtener índice
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
                        onPressed: () {
                          setState(() {
                            _reviews.removeAt(index); // Eliminar reseña
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
