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

  // State variables
  bool _isHomeIconVisible = false; // Control for logo visibility
  int selectedDrawerIndex = 1; // Selected index for menu

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
    // You can handle navigation to other pages if necessary
  }

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible = !_isHomeIconVisible; // Toggle icon visibility
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

                // Wait for animation to finish before navigating
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
                // Featured image
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/cabañaparaiso.jpg'), // Change to your image
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(height: 15),
                // Attention-grabbing description
                Text(
                  '🌲 Vive una experiencia única en nuestra cabaña del árbol, un refugio mágico en las alturas. Rodeado de la naturaleza y con la mejor vista de Ibagué, aquí podrás relajarte, desconectar y disfrutar de una escapada que recordarás para siempre.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                // Services section
                _buildSectionTitle("SERVICIOS"),
                Column(
                  children: [
                    servicioTarjeta(Icons.hotel, 'Hospedaje', 14),
                    servicioTarjeta(Icons.kitchen, 'Nevera', 14),
                    servicioTarjeta(
                        Icons.visibility, 'Avistamiento de aves', 14),
                    servicioTarjeta(Icons.bathtub, 'Baño y ducha', 14),
                    servicioTarjeta(Icons.pool, 'Piscina pequeña', 14),
                    servicioTarjeta(Icons.waterfall_chart, 'Río y cascada', 14),
                    servicioTarjeta(Icons.games, 'Juegos de mesa', 14),
                    servicioTarjeta(
                        Icons.landscape, 'La mejor vista de Ibagué', 14),
                    servicioTarjeta(Icons.bluetooth, 'Cabina Bluetooth', 14),
                    servicioTarjeta(Icons.fireplace, 'Asador pequeño', 14),
                  ],
                ),
                SizedBox(height: 20),
                // Location card
                crearTarjeta(Icons.location_on, 'UBICACIÓN',
                    'Estamos a 10 minutos de la Universidad de Ibagué en el barrio Ambalá. Puedes llegar en uber, moto o carro hasta la entrada del lugar. Trae toda la comida y bebida que desees.\nIngreso: 4pm - 6pm\nSalida: Al otro día antes de medio día'),
                // Prices card
                crearTarjeta(Icons.attach_money, 'PRECIOS',
                    'Lunes a jueves: \$120.000\nViernes y domingo: \$180.000\nSábado, festivo o día antes de festivo: \$200.000'),
                // Hiking card
                crearTarjeta(Icons.directions_walk, 'SENDERISMO',
                    '15 minutos desde la entrada hasta la cabaña. Reserva la cabaña completa para disfrutar sin compartir.'),
                // Parking card
                crearTarjeta(Icons.local_parking, 'PARQUEADERO',
                    'Moto \$8,000 | Carro \$12,000'),
                SizedBox(height: 20),
                // New card: Availability confirmation
                crearTarjeta(Icons.phone, 'CONFIRMA DISPONIBILIDAD',
                    'Confirma disponibilidad y abona la mitad para reservar:\nNequi 3208947802 - Jorge John\nCuenta Ahorros Bancolombia 86960992140'),
                // Reservation section
                _buildSectionTitle("Reserva tu experiencia"),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField("Nombre", _nameController,
                          TextInputType.text, Icons.person),
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
                          Icons.group),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Logic to send the reservation
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Reserva realizada con éxito')));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 32),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text('Confirmar Reserva',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show dialog when pressing phone icon
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Contacto'),
                content: Text(
                    'Llama al +573208947802 para más información o reservas.'),
                actions: [
                  TextButton(
                    child: Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.phone),
        backgroundColor: Colors.teal[800],
      ),
    );
  }

  // Function to create custom cards
  Widget crearTarjeta(IconData icono, String titulo, String descripcion) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      elevation: 2,
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
                Icon(icono, color: Colors.teal[700], size: 24),
                SizedBox(width: 10),
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              descripcion,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build text fields for the form
  Widget _buildTextField(String label, TextEditingController controller,
      TextInputType keyboardType, IconData icon,
      {VoidCallback? onTap}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese $label';
        }
        return null;
      },
      onTap: onTap,
      readOnly: onTap != null,
    );
  }

  // Function to build section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.teal[900],
      ),
    );
  }

  // Function to create service cards
  Widget servicioTarjeta(IconData icon, String nombre, double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal[700], size: size),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              nombre,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
