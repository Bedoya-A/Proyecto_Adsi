import 'package:flutter/material.dart';
import 'package:prueba2/Menu.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cabaña del Árbol'),
        backgroundColor: Colors.green[800],
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png', // Cambia esta ruta por la de tu logo
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      endDrawer: Menu(
        selectedDrawerIndex: selectedDrawerIndex,
        onSelectDrawerItem: onSelectDrawerItem,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Reservar ahora'),
                content:
                    Text('Llama al +573008037502 para confirmar tu reserva.'),
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
        backgroundColor: Colors.green[700],
        child: Icon(Icons.phone),
        tooltip: 'Llama para reservar',
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
                    servicioTarjeta(Icons.bed, 'Cama Queen muy cómoda', 14),
                    servicioTarjeta(
                        Icons.visibility, 'Avistamiento de aves', 14),
                    servicioTarjeta(Icons.water, 'Río y cascada', 14),
                    servicioTarjeta(Icons.restaurant_menu, 'Asador', 14),
                    servicioTarjeta(Icons.bathtub, 'Baño y ducha', 14),
                    servicioTarjeta(Icons.wine_bar, 'Copas, vasos, platos', 14),
                    servicioTarjeta(Icons.terrain, 'Hamaca y terraza', 14),
                    servicioTarjeta(Icons.games, 'Juegos de mesa', 14),
                  ],
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
                Card(
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
                          style: TextStyle(fontSize: 16, color: Colors.black87),
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
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                      ],
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    fontSize: 16, color: Colors.black87),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Parqueadero gratuito para los huéspedes.',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
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
                        decoration:
                            InputDecoration(labelText: 'Nombre completo'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingresa tu nombre';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Teléfono'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingresa tu número de teléfono';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _dateStartController,
                        decoration:
                            InputDecoration(labelText: 'Fecha de inicio'),
                        readOnly: true,
                        onTap: () => _selectDate(_dateStartController),
                      ),
                      TextFormField(
                        controller: _dateEndController,
                        decoration: InputDecoration(labelText: 'Fecha de fin'),
                        readOnly: true,
                        onTap: () => _selectDate(_dateEndController),
                      ),
                      TextFormField(
                        controller: _numPeopleController,
                        decoration:
                            InputDecoration(labelText: 'Número de personas'),
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
                                  content: Text('Reserva realizada con éxito')),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget servicioTarjeta(IconData icono, String texto, double size) {
    return Card(
      child: ListTile(
        leading: Icon(icono, size: size, color: Colors.green[700]),
        title: Text(texto, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget precioItem(String dia, String precio, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(dia, style: TextStyle(fontSize: 18)),
        Text(precio, style: TextStyle(fontSize: 18, color: color)),
      ],
    );
  }
}
