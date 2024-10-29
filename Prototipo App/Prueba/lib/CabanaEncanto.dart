import 'package:flutter/material.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/HomePage.dart';

class CabanaEncanto extends StatefulWidget {
  const CabanaEncanto({super.key});

  @override
  _CabanaEncantoState createState() => _CabanaEncantoState();
}

class _CabanaEncantoState extends State<CabanaEncanto> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateStartController = TextEditingController();
  final _dateEndController = TextEditingController();
  final _numPeopleController = TextEditingController();
  int selectedDrawerIndex = 1;
  bool _isHomeIconVisible = false; // Inicializa la variable

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

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
            colors: [
              Colors.tealAccent,
              Colors.blueAccent,
              Colors.purpleAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen destacada
                Image.asset(
                  'assets/cabañaencanto.jpg', // Cambia por la imagen adecuada
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),

                // Descripción de características
                _buildSectionCard(
                    "Características", Icons.star, _buildFeatureList()),

                // Ubicación
                _buildSectionCard(
                    "Ubicación", Icons.location_on, _buildLocationText()),

                // Sección de precios
                _buildSectionCard("Precios", Icons.money, _buildPriceList()),

                // Senderismo
                _buildSectionCard(
                    "Senderismo", Icons.hiking, _buildHikingText()),

                // Formulario de reserva
                _buildSectionCard("Reserva tu experiencia", Icons.bookmark,
                    _buildReservationForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para las tarjetas de sección
  Widget _buildSectionCard(String title, IconData icon, Widget content) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.brown[700]),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              content,
            ],
          ),
        ),
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
        const SizedBox(height: 10),
        Text(
          "Ingreso: Puedes llegar desde las 4:00 pm, máximo a las 6:00 pm.",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(
          "Salida: Al otro día antes del mediodía.",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
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

  // Widget para el texto de senderismo
  Widget _buildHikingText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "De la entrada hasta la cabaña son 10 minutos de senderismo (400 metros). Por este valor reservas la cabaña entera, no la compartes con nadie, es una cabaña rústica, el plan no es de lujo.",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(
          "Parqueadero: moto a \$8.000 y carro a \$12.000.",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(
          "En la entrada te reciben, llevan y entregan la cabaña.",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(
          "Confirmamos disponibilidad y reserva del lugar a través de este formulario.",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }

  // Widget para el formulario de reserva
  Widget _buildReservationForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Teléfono'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu número de teléfono';
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
            decoration: const InputDecoration(labelText: 'Fecha de fin'),
            readOnly: true,
            onTap: () => _selectDate(_dateEndController),
          ),
          TextFormField(
            controller: _numPeopleController,
            decoration: const InputDecoration(labelText: 'Número de personas'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa el número de personas';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Aquí puedes enviar los datos a tu base de datos o API
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reserva enviada')),
                );
              }
            },
            child: const Text('Reservar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[600],
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
