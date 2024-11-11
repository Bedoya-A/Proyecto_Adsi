import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/HomePage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Menu.dart';

class CabanaParaiso extends StatefulWidget {
  @override
  State<CabanaParaiso> createState() => _CabanaParaisoState();
}

class _CabanaParaisoState extends State<CabanaParaiso> {
  bool _isHomeIconVisible = false; // Control for logo visibility
  int selectedDrawerIndex = 1; // Selected index for menu
  double _rating = 0; // Initial rating value
  TextEditingController _reviewController = TextEditingController();

  // List to store reviews
  List<Map<String, dynamic>> _reviews = [];

  final List<String> imgList = [
    'assets/paraiso1.png',
    'assets/paraiso2.png',
    'assets/paraiso3.png',
    'assets/paraiso4.png',
    'assets/paraiso5.png',
  ];
  int _current = 0;

  // Date selection logic
  void _selectDate(TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  // Function to select drawer item
  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
  }

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible = !_isHomeIconVisible; // Toggle icon visibility
    });
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
          title: Text('Cabaña Paraíso', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.teal[800],
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _onLogoTap(); // Change icon visibility on click

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
                          size: 40, // Size of home icon
                          color: Colors.white,
                        )
                      : CircleAvatar(
                          key: ValueKey('logoIcon'),
                          radius: 20, // Radius of the logo
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                ),
              ),
            ),
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
                  Container(
                    height: 320,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/cabañaparaiso.jpg'), // Cambia a tu imagen
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(height: 20), // Espaciado adicional
                  // Descripción llamativa
                  Text(
                    '🌲 Vive una experiencia única en nuestra cabaña del árbol...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 30), // Espaciado adicional
                  // Sección de servicios
                  _buildSectionTitle("SERVICIOS", Icons.star),
                  Column(
                    children: [
                      servicioTarjeta(Icons.hotel, 'Hospedaje', 25),
                      servicioTarjeta(Icons.kitchen, 'Nevera', 25),
                      servicioTarjeta(
                          Icons.visibility, 'Avistamiento de aves', 25),
                      servicioTarjeta(Icons.bathtub, 'Baño y ducha', 25),
                      servicioTarjeta(Icons.pool, 'Piscina pequeña', 25),
                      servicioTarjeta(
                          Icons.waterfall_chart, 'Río y cascada', 25),
                      servicioTarjeta(Icons.games, 'Juegos de mesa', 14),
                      servicioTarjeta(
                          Icons.landscape, 'La mejor vista de Ibagué', 25),
                      servicioTarjeta(Icons.bluetooth, 'Cabina Bluetooth', 25),
                      servicioTarjeta(Icons.fireplace, 'Asador pequeño', 25),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CarouselSlider(
                          items: imgList
                              .map((item) => Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
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
                            icon:
                                Icon(Icons.arrow_back_ios, color: Colors.white),
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
                  Divider(
                    thickness: 2,
                    color: Colors.white, // Línea separadora más notoria
                  ),
                  SizedBox(height: 40), // Más espacio entre apartados
                  // Tarjeta de ubicación

                  _buildSectionTitle("UBICACIÓN", Icons.location_on),
                  crearTarjeta(
                    Icons.location_on,
                    'Estamos a 10 minutos de la Universidad de Ibagué en el barrio Ambalá...',
                    Center(
                      child: Image.asset(
                        'assets/mapaparaiso.jpg', // Reemplaza con el nombre de la imagen que quieres mostrar
                        width: 450,
                        height:
                            350, // Ajuste de la imagen (puedes usar BoxFit.fill, BoxFit.contain, etc.)
                      ),
                    ),
                  ),

                  Divider(thickness: 2, color: Colors.white),
                  SizedBox(height: 40),
                  // Tarjeta de precios
                  _buildSectionTitle("PRECIOS", Icons.attach_money),
                  crearTarjeta(Icons.attach_money,
                      'Lunes a jueves: \$120.000\nViernes y domingo: \$180.000\nSábado, festivo o día antes de festivo: \$200.000'),
                  Divider(thickness: 2, color: Colors.white),
                  SizedBox(height: 40),
                  // Tarjeta de senderismo
                  _buildSectionTitle("SENDERISMO", Icons.directions_walk),
                  crearTarjeta(Icons.directions_walk,
                      '15 minutos desde la entrada hasta la cabaña...'),
                  Divider(thickness: 2, color: Colors.white),
                  SizedBox(height: 40),
                  // Tarjeta de parqueadero
                  _buildSectionTitle("PARQUEADERO", Icons.local_parking),
                  crearTarjeta(
                      Icons.local_parking, 'Moto \$8,000 | Carro \$12,000'),
                  Divider(thickness: 2, color: Colors.white),
                  SizedBox(height: 40),
                  SizedBox(height: 20),
                  // Nueva tarjeta: Confirmación de disponibilidad
                  _buildSectionTitle("CONFIRMA DISPONIBILIDAD", Icons.phone),
                  crearTarjeta(Icons.phone,
                      "Confirma disponibilidad y abona tu reserva llamando al 312 564 56 78 o escribiendo al WhatsApp"),
                  SizedBox(height: 30),
                  // Sección de reservas
                  SizedBox(height: 30),
                  // Sección de reseñas
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
        ));
  }

  // Método para crear un campo de texto genérico
  Widget _buildTextField(String label, TextEditingController controller,
      TextInputType inputType, IconData icon,
      {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese un valor';
          }
          return null;
        },
      ),
    );
  }

  // Método para crear tarjetas de servicios y detalles
  Widget servicioTarjeta(IconData icon, String texto, double size) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, size: size),
        title: Text(texto),
      ),
    );
  }

  // Método para crear las tarjetas de contenido general
// Modifica la función crearTarjeta para aceptar un widget adicional
  Widget crearTarjeta(IconData icon, String content, [Widget? extraContent]) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.teal[900]),
                SizedBox(width: 8),
                Text(
                  content,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            if (extraContent != null) ...[
              SizedBox(height: 10),
              extraContent,
            ],
          ],
        ),
      ),
    );
  }

  // Método para construir los títulos de las secciones
  Widget _buildSectionTitle(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 60, 157, 79),
            Color.fromARGB(255, 117, 240, 36)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
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
