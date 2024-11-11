import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/FormularioReserva.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/HomePage.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
=======
import 'package:url_launcher/url_launcher.dart';
>>>>>>> main

class CabanaEncanto extends StatefulWidget {
  const CabanaEncanto({super.key});

  @override
  _CabanaEncantoState createState() => _CabanaEncantoState();
}

class _CabanaEncantoState extends State<CabanaEncanto> {
  int selectedDrawerIndex = 1;
  bool _isHomeIconVisible = false; // Inicializa la variable
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

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible = !_isHomeIconVisible; // Alterna la visibilidad
    });
  }

  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
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

  void _showReservationForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ReservationForm(
            onSubmit: (name, phone, date, numPeople) {
              // Lógica para manejar la reserva
              print('Reserva: $name, $phone, $date, $numPeople');
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _onLogoTap(); // Cambia la visibilidad del ícono al hacer clic
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
                          size: 40,
                          color: Colors.white,
                        )
                      : CircleAvatar(
                          key: ValueKey('logoIcon'),
                          radius: 20,
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                'Cabaña El Encanto',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.brown[400],
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
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

<<<<<<< HEAD
                // Sección de ubicación
=======
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
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
>>>>>>> main
                _buildSectionCard(
                    "Ubicación", Icons.location_on, _buildLocationText()),
                _buildSectionCard("Precios", Icons.money, _buildPriceList()),
                _buildSectionCard(
                    "Senderismo", Icons.hiking, _buildHikingText()),
<<<<<<< HEAD

                // Parqueadero
                _buildSectionCard(
                    "Parqueadero", Icons.local_parking, _buildParkingText()),

                // Ingreso
                _buildSectionCard(
                    "Ingreso", Icons.access_time, _buildIngresoText()),

                // Salida
                _buildSectionCard(
                    "Salida", Icons.exit_to_app, _buildSalidaText()),

                // Nueva tarjeta: Confirmación de disponibilidad y contacto
                _buildSectionCard("Confirma tu disponibilidad y reserva",
                    Icons.phone, _buildContactInfo()),

                // Formulario de reserva
                _buildSectionCard("Reserva tu experiencia", Icons.bookmark,
                    _buildReservationForm()),
=======
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
>>>>>>> main
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20),
        child: FloatingActionButton(
          onPressed:
              _showReservationForm, // Función para mostrar el formulario de reserva
          backgroundColor: Colors.green[700],
          child: Icon(Icons.bookmark_add, size: 30), // Icono del botón
        ),
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
              Text(feature['text'] as String,
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Widget para la ubicación
  Widget _buildLocationText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Estamos a 10 minutos de la Universidad de Ibagué en el barrio Ambalá, puedes llegar en Uber, moto o carro hasta la entrada del lugar.",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(
          "Puedes subir toda la comida y bebida que desees, ya que nosotros no vendemos.",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
<<<<<<< HEAD
=======
        ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Center(
              child: Image.network(
                'assets/mapacabanaEncanto.jpg',
                width: 450, // Ancho deseado
                height: 350, // Alto deseado
                fit: BoxFit.contain, // Para que se ajuste sin distorsión
              ),
            )),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
>>>>>>> main
      ],
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
          child: Text(price,
              style: const TextStyle(fontSize: 16, color: Colors.black)),
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
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
<<<<<<< HEAD
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
          style: TextStyle(fontSize: 16, color: Colors.black),
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
          style: TextStyle(fontSize: 16, color: Colors.black),
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
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
=======
>>>>>>> main
      ],
    );
  }

<<<<<<< HEAD
  // Widget para el formulario de reserva
  Widget _buildReservationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su nombre';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Teléfono'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su teléfono';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _dateStartController,
            decoration: const InputDecoration(labelText: 'Fecha de inicio'),
            readOnly: true,
            onTap: () => _selectDate(_dateStartController),
          ),
          TextFormField(
            controller: _dateEndController,
            decoration: const InputDecoration(labelText: 'Fecha de salida'),
            readOnly: true,
            onTap: () => _selectDate(_dateEndController),
          ),
          TextFormField(
            controller: _numPeopleController,
            decoration: const InputDecoration(labelText: 'Número de personas'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el número de personas';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Procesa la reserva
              }
            },
            child: const Text('Confirmar Reserva'),
=======
  // Widget para el parqueadero
  Widget _buildParkingText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " moto a \$8.000 y carro a \$12.000.",
          style: TextStyle(fontSize: 16, color: Colors.black),
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
          style: TextStyle(fontSize: 16, color: Colors.black),
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
          style: TextStyle(fontSize: 16, color: Colors.black),
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
>>>>>>> main
          ),
        ],
      ),
    );
  }

  // Widget para la nueva tarjeta de contacto y confirmación
  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Confirma disponibilidad y abona tu reserva llamando al 3125645678 o escribiendo al WhatsApp.",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            final url = "https://wa.me/573125645678"; // Enlace de WhatsApp
            // Usa este enlace para abrir WhatsApp sin dependencias
            print("Enlace WhatsApp: $url"); // Solo loguea el enlace por ahora
          },
          child: Text("Escribir por WhatsApp"),
        ),
      ],
    );
  }
}
