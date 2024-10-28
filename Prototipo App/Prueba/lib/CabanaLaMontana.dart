import 'package:flutter/material.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/HomePage.dart'; // Asegúrate de que la ruta sea correcta

class CabanaLaMontana extends StatefulWidget {
  @override
  _CabanaLaMontanaState createState() => _CabanaLaMontanaState();
}

class _CabanaLaMontanaState extends State<CabanaLaMontana> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateStartController = TextEditingController();
  final _dateEndController = TextEditingController();
  final _numPeopleController = TextEditingController();
  int selectedDrawerIndex = 1;

  // Lógica para seleccionar fechas
  void _selectDate(TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != DateTime.now()) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
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
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navegar a la página de inicio
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Image.asset(
                'assets/logo.png', // Ruta de tu logo
                height: 40, // Altura del logo
              ),
            ),
            SizedBox(width: 10), // Espaciado entre el logo y el título
            Flexible(
              // Usar Flexible para evitar el desbordamiento
              child: Text(
                'Cabaña La Montaña',
                overflow:
                    TextOverflow.ellipsis, // Agregar comportamiento de recorte
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
            colors: [Color.fromARGB(255, 193, 255, 122), Colors.green],
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
                  'assets/cabanamontana.png', // Cambia por la imagen adecuada
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),

                // Descripción general
                Text(
                  '¡Un lugar mágico donde la naturaleza te envuelve! 🌿🏞\n\n'
                  'La Montaña te ofrece una experiencia inolvidable, perfecta para aventureros que buscan tranquilidad y conexión con la naturaleza. '
                  'Descubre las vistas más impresionantes de Ibagué y respira el aire puro de las alturas. ¡Es un refugio que te recargará de energía!',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),

                // Distancia
                Text(
                  '📍 A solo 10 minutos de la Universidad de Ibagué en el barrio Ambalá',
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                // Sección de servicios
                buildServiciosSection(),

                // Sección de precios, senderismo, desayuno
                buildInfoSection(),

                // Formulario de reserva
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
                            // Lógica para enviar la reserva
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
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Reservar ahora'),
              content:
                  Text('Llama al +573008037502 para confirmar tu reserva.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cerrar', style: TextStyle(color: Colors.purple)),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.green[700],
        child: Icon(Icons.phone),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      TextInputType inputType, IconData icon,
      {Function()? onTap}) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      onTap: onTap, // Llama a la función de selección de fecha si está definida
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese $label';
        }
        return null;
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  // Método para construir la sección de servicios
  Widget buildServiciosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '✨ SERVICIOS ✨',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Column(
          children: [
            servicioTarjeta(Icons.bed, 'Cama doble con cobija', 14),
            servicioTarjeta(Icons.bathtub, 'Baño privado', 14),
            servicioTarjeta(Icons.visibility, 'La mejor vista de Ibagué', 14),
            servicioTarjeta(Icons.nature, 'Entorno natural único', 14),
            servicioTarjeta(Icons.biotech, 'Avistamiento de aves', 14),
            servicioTarjeta(Icons.local_florist, 'Senderos de aventura', 14),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // Método para construir la sección de información
  Widget buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        infoCard(
          title: '💵 PRECIOS',
          content: '• Lunes a Jueves: \$80,000\n• Viernes a Domingo: \$120,000',
        ),
        SizedBox(height: 10),
        infoCard(
          title: '🚶‍♂️ SENDERISMO',
          content: '¡Explora los hermosos senderos que rodean la cabaña!',
        ),
        SizedBox(height: 10),
        infoCard(
          title: '🥐 DESAYUNO',
          content: 'Incluido en tu reserva para comenzar el día con energía.',
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // Método para crear una tarjeta de servicio
  Widget servicioTarjeta(IconData icon, String title, double iconSize) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, size: iconSize, color: Colors.green),
        title: Text(title, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  // Método para crear una tarjeta de información
  Widget infoCard({required String title, required String content}) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(content, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
