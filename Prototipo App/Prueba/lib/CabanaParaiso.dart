import 'package:flutter/material.dart';
import 'package:prueba2/HomePage.dart';
import 'Menu.dart';

class CabanaParaiso extends StatefulWidget {
  @override
  State<CabanaParaiso> createState() => _CabanaParaisoState();
}

class _CabanaParaisoState extends State<CabanaParaiso> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateStartController = TextEditingController();
  final _dateEndController = TextEditingController();
  final _numPeopleController = TextEditingController();

  bool _isHomeIconVisible = false; // Control for logo visibility
  int selectedDrawerIndex = 1; // Selected index for menu
  double _rating = 0; // Initial rating value
  TextEditingController _reviewController = TextEditingController();

  // List to store reviews
  List<Map<String, dynamic>> _reviews = [];

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
                transitionBuilder: (Widget child, Animation<double> animation) {
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
                  '🌲 Vive una experiencia única en nuestra cabaña del árbol, un refugio mágico en las alturas. Rodeado de la naturaleza y con la mejor vista de Ibagué, aquí podrás relajarte, desconectar y disfrutar de una escapada que recordarás para siempre.',
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
                    servicioTarjeta(
                      Icons.kitchen,
                      'Nevera',
                      25,
                    ),
                    servicioTarjeta(
                        Icons.visibility, 'Avistamiento de aves', 25),
                    servicioTarjeta(Icons.bathtub, 'Baño y ducha', 25),
                    servicioTarjeta(Icons.pool, 'Piscina pequeña', 25),
                    servicioTarjeta(Icons.waterfall_chart, 'Río y cascada', 25),
                    servicioTarjeta(Icons.games, 'Juegos de mesa', 14),
                    servicioTarjeta(
                        Icons.landscape, 'La mejor vista de Ibagué', 25),
                    servicioTarjeta(Icons.bluetooth, 'Cabina Bluetooth', 25),
                    servicioTarjeta(Icons.fireplace, 'Asador pequeño', 25),
                  ],
                ),
                Divider(
                    thickness: 2,
                    color: Colors.white), // Línea separadora más notoria
                SizedBox(height: 40), // Más espacio entre apartados
                // Tarjeta de ubicación
                _buildSectionTitle("UBICACIÓN", Icons.location_on),
                crearTarjeta(Icons.location_on,
                    'Estamos a 10 minutos de la Universidad de Ibagué en el barrio Ambalá. Puedes llegar en uber, moto o carro hasta la entrada del lugar. Trae toda la comida y bebida que desees.\nIngreso: 4pm - 6pm\nSalida: Al otro día antes de medio día'),
                Divider(
                    thickness: 2,
                    color: Colors.white), // Línea separadora más notoria
                SizedBox(height: 40), // Más espacio entre apartados
                // Tarjeta de precios
                _buildSectionTitle("PRECIOS", Icons.attach_money),
                crearTarjeta(Icons.attach_money,
                    'Lunes a jueves: \$120.000\nViernes y domingo: \$180.000\nSábado, festivo o día antes de festivo: \$200.000'),
                Divider(
                    thickness: 2,
                    color: Colors.white), // Línea separadora más notoria
                SizedBox(height: 40), // Más espacio entre apartados
                // Tarjeta de senderismo
                _buildSectionTitle("SENDERISMO", Icons.directions_walk),
                crearTarjeta(Icons.directions_walk,
                    '15 minutos desde la entrada hasta la cabaña. Reserva la cabaña completa para disfrutar sin compartir.'),
                Divider(
                    thickness: 2,
                    color: Colors.white), // Línea separadora más notoria
                SizedBox(height: 40), // Más espacio entre apartados
                // Tarjeta de parqueadero
                _buildSectionTitle("PARQUEADERO", Icons.local_parking),
                crearTarjeta(
                    Icons.local_parking, 'Moto \$8,000 | Carro \$12,000'),
                Divider(
                    thickness: 2,
                    color: Colors.white), // Línea separadora más notoria
                SizedBox(height: 40), // Más espacio entre apartados
                SizedBox(height: 20),
                // Nueva tarjeta: Confirmación de disponibilidad
                _buildSectionTitle("CONFIRMA DISPONIBILIDAD", Icons.phone),
                crearTarjeta(Icons.phone,
                    'Confirma disponibilidad y abona tu reserva llamando al 312 564 56 78 o escribiendo al WhatsApp.'),
                SizedBox(height: 30), // Espaciado adicional
                // Sección de reservas
                _buildSectionTitle(
                    "RESERVA TU EXPERIENCIA", Icons.calendar_today),
                SizedBox(height: 20), // Separación adicional
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField("Nombre Completo", _nameController,
                          TextInputType.name, Icons.person),
                      SizedBox(height: 10),
                      _buildTextField("Número de Teléfono", _phoneController,
                          TextInputType.phone, Icons.phone),
                      SizedBox(height: 10),
                      _buildTextField("Fecha de Inicio", _dateStartController,
                          TextInputType.none, Icons.calendar_today,
                          onTap: () => _selectDate(_dateStartController)),
                      SizedBox(height: 10),
                      _buildTextField("Fecha de Fin", _dateEndController,
                          TextInputType.none, Icons.calendar_today,
                          onTap: () => _selectDate(_dateEndController)),
                      SizedBox(height: 10),
                      _buildTextField(
                          "Número de Personas",
                          _numPeopleController,
                          TextInputType.number,
                          Icons.people),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('¡Reserva confirmada!'),
                                content: Text('Reserva realizada con éxito'),
                              ),
                            );
                          }
                        },
                        child: Text('Confirmar Reserva'),
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
    );
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
  Widget crearTarjeta(IconData icono, String texto) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icono),
        title: Text(texto),
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
