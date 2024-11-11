import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/HomePage.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa tu HomePage para la navegación

class CabanaDelArbol extends StatefulWidget {
  @override
  _CabanaDelArbolState createState() => _CabanaDelArbolState();
}

class _CabanaDelArbolState extends State<CabanaDelArbol> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _numPeopleController = TextEditingController();
  int selectedDrawerIndex = 1;
  bool _isHomeIconVisible = false; // Controla la visibilidad del ícono
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

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      controller.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
  }

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible =
          !_isHomeIconVisible; // Cambia la visibilidad del ícono
    });

    // Espera a que la animación termine antes de navegar
    Future.delayed(Duration(milliseconds: 350), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
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
          title: Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _onLogoTap(); // Cambia la visibilidad del ícono al hacer clic

                    // Espera a que la animación termine antes de navegar
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
                            size: 40, // Tamaño del ícono de inicio
                            color: Colors.white,
                          )
                        : CircleAvatar(
                            key: ValueKey('logoIcon'),
                            radius: 20, // Radio del logo
                            backgroundImage: AssetImage('assets/logo.png'),
                          ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Espaciado entre el logo y el título
              Flexible(
                // Usar Flexible para evitar el desbordamiento
                child: Text(
                  'Cabaña del arbol',
                  overflow: TextOverflow
                      .ellipsis, // Agregar comportamiento de recorte
                  maxLines: 1, // Limitar a una línea
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green[700],
          automaticallyImplyLeading: false, // Elimina la flecha de regresar
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context)
                      .openEndDrawer(); // Abre el menú lateral a la derecha
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
              colors: [Colors.green[200]!, Colors.green[400]!],
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
                          '✨ SERVICIOS ✨',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
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
                            servicioTarjeta(
                                Icons.restaurant_menu, 'Asador', 14),
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
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
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

                        // Ubicación con interacción
                        Text(
                          '📍 UBICACIÓN',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.network(
                              'assets/mapacabanaArbol.jpg',
                              width: 400, // Ancho deseado
                              height: 300, // Alto deseado
                              fit: BoxFit
                                  .contain, // Para que se ajuste sin distorsión
                            )),
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
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.directions_walk,
                                          color: Colors.green[700]),
                                      SizedBox(width: 8),
                                      Text(
                                        '20 minutos de senderismo (800m)',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87),
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
                                        color: Colors.green[700], size: 24),
                                    SizedBox(width: 8),
                                    Text(
                                      '💵 PRECIOS:',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[900],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    precioItem('Lunes a Jueves', '150.000',
                                        Colors.green[600]!),
                                    precioItem('Viernes o Domingos', '200.000',
                                        Colors.green[700]!),
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
                                    color: Colors.green[700], size: 24),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '🚶 SENDERISMO:',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[900],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '20 minutos de senderismo (800m)',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87),
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
                                    color: Colors.green[700], size: 24),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '🚗 PARQUEADERO:',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[900],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Parqueadero gratuito.',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Formulario de reserva
                        Text(
                          '📅 RESERVA TU ESTANCIA',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                    labelText: 'Nombre completo'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingresa tu nombre';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _phoneController,
                                decoration:
                                    InputDecoration(labelText: 'Teléfono'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingresa tu número de teléfono';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _dateStartController,
                                decoration: InputDecoration(
                                    labelText: 'Fecha de inicio'),
                                readOnly: true,
                                onTap: () => _selectDate(_dateStartController),
                              ),
                              TextFormField(
                                controller: _dateEndController,
                                decoration:
                                    InputDecoration(labelText: 'Fecha de fin'),
                                readOnly: true,
                                onTap: () => _selectDate(_dateEndController),
                              ),
                              TextFormField(
                                controller: _numPeopleController,
                                decoration: InputDecoration(
                                    labelText: 'Número de personas'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingresa el número de personas';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Aquí puedes agregar la lógica para manejar la reserva.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Reserva realizada con éxito')),
                                    );
                                  }
                                },
                                child: Text('Reservar'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[600],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            int index =
                                _reviews.indexOf(review); // Obtener índice
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
                      ]))),
        ));
  }

  Widget servicioTarjeta(IconData icon, String servicio, double size) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.green[600]),
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
