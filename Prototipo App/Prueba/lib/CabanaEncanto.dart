import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:prueba2/Menu.dart';

class CabanaEncanto extends StatefulWidget {
  const CabanaEncanto({super.key});

  @override
  _CabanaEncantoState createState() => _CabanaEncantoState();
}

class _CabanaEncantoState extends State<CabanaEncanto> {
  File? _image; // Para almacenar la imagen seleccionada
  final _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateStartController = TextEditingController();
  final _dateEndController = TextEditingController();
  final _numPeopleController = TextEditingController();
  int selectedDrawerIndex = 1;

  // Función para seleccionar una imagen desde la galería
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

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

  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cabaña El Encanto'),
        backgroundColor: Colors.brown[400],
      ),
      drawer: Menu(
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
                'assets/cabañaencanto.jpg', // Cambia por la imagen adecuada
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
                "Estamos a 10 minutos de la Universidad de Ibagué en el barrio Ambalá, puedes llegar en Uber, moto o carro hasta la entrada del lugar.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Puedes subir toda la comida y bebida que desees, ya que nosotros no vendemos.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Ingreso: Puedes llegar desde las 4:00 pm, máximo a las 6:00 pm.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Salida: Al otro día antes del mediodía.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Sección de precios
              _buildSectionTitle("Precios"),
              _buildPriceList(),

              // Senderismo
              _buildSectionTitle("Senderismo"),
              Text(
                "De la entrada hasta la cabaña son 10 minutos de senderismo (400 metros). Por este valor reservas la cabaña entera, no la compartes con nadie, es una cabaña rústica, el plan no es de lujo.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Parqueadero: moto a \$8.000 y carro a \$12.000.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "En la entrada te reciben, llevan y entregan la cabaña.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Confirmamos disponibilidad y abonas la mitad para reservar al Nequi 3208947802 a nombre de Jorge John o a la cuenta de ahorros Bancolombia 86960992140.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

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
                          // Lógica para enviar la reserva
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
        Text("Entre Lunes y Jueves",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("1 Pareja: \$120.000"),
        Text("2 Parejas: \$140.000"),
        const SizedBox(height: 10),
        Text("Viernes o Domingo",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("1 Pareja: \$180.000"),
        Text("2 Parejas: \$210.000"),
        const SizedBox(height: 10),
        Text("Sábado, festivo o día antes de festivo",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("1 Pareja: \$200.000"),
        Text("2 Parejas: \$230.000"),
      ],
    );
  }

  // Widget para los campos de texto del formulario
  Widget _buildTextField(String label, TextEditingController controller,
      TextInputType keyboardType, IconData icon,
      {Function()? onTap}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingrese $label';
        }
        return null;
      },
    );
  }
}
