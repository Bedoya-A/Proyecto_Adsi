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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen destacada
              Image.asset(
                'assets/cabañaencanto.jpg',
                width: 750,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              // Descripción de características
              _buildSectionTitle("Características"),
              _buildFeatureList(),
              // Ubicación
              _buildSectionTitle("Ubicación"),
              Text(
                "Estamos a 10 minutos de la Universidad de Ibagué en el barrio Ambalá...",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              // Otros textos...
              // Formulario de reserva
              _buildSectionTitle("Reserva tu experiencia"),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField("Nombre", _nameController,
                        TextInputType.text, Icons.person),
                    const SizedBox(height: 10),
                    _buildTextField("Número de Teléfono", _phoneController,
                        TextInputType.phone, Icons.phone),
                    const SizedBox(height: 10),
                    _buildTextField("Fecha de Inicio", _dateStartController,
                        TextInputType.none, Icons.calendar_today,
                        onTap: () => _selectDate(_dateStartController)),
                    const SizedBox(height: 10),
                    _buildTextField("Fecha de Fin", _dateEndController,
                        TextInputType.none, Icons.calendar_today,
                        onTap: () => _selectDate(_dateEndController)),
                    const SizedBox(height: 10),
                    _buildTextField("Número de Personas", _numPeopleController,
                        TextInputType.number, Icons.group),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Reserva realizada con éxito')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 32),
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Confirmar Reserva',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para los títulos de sección
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.brown[700],
        ),
      ),
    );
  }

  // Widget para la lista de características con iconos
  Widget _buildFeatureList() {
    const List<Map<String, dynamic>> features = [
      {'text': 'Hospedaje 1 noche para 1 o 2 parejas', 'icon': Icons.bed},
      // Otros elementos...
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
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Widget para la lista de precios
  Widget _buildPriceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Viernes", style: TextStyle(fontWeight: FontWeight.bold)),
        // Otros precios...
      ],
    );
  }

  // Widget para el campo de texto
  Widget _buildTextField(String label, TextEditingController controller,
      TextInputType keyboardType, IconData icon,
      {VoidCallback? onTap}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa $label';
        }
        return null;
      },
    );
  }
}
