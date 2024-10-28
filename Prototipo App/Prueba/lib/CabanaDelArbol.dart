import 'package:flutter/material.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/HomePage.dart'; // Importa tu HomePage para la navegación

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

                // Formulario de reserva
                Text(
                  '📅 RESERVA',
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
                        decoration: InputDecoration(labelText: 'Nombre'),
                        validator: (value) =>
                            value!.isEmpty ? 'Ingresa tu nombre' : null,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Teléfono'),
                        validator: (value) =>
                            value!.isEmpty ? 'Ingresa tu teléfono' : null,
                      ),
                      TextFormField(
                        controller: _dateStartController,
                        decoration:
                            InputDecoration(labelText: 'Fecha de Inicio'),
                        readOnly: true,
                        onTap: () => _selectDate(_dateStartController),
                        validator: (value) =>
                            value!.isEmpty ? 'Selecciona una fecha' : null,
                      ),
                      TextFormField(
                        controller: _dateEndController,
                        decoration: InputDecoration(labelText: 'Fecha de Fin'),
                        readOnly: true,
                        onTap: () => _selectDate(_dateEndController),
                        validator: (value) =>
                            value!.isEmpty ? 'Selecciona una fecha' : null,
                      ),
                      TextFormField(
                        controller: _numPeopleController,
                        decoration:
                            InputDecoration(labelText: 'Número de Personas'),
                        validator: (value) => value!.isEmpty
                            ? 'Ingresa el número de personas'
                            : null,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Procesar la reserva
                          }
                        },
                        child: Text('Reservar'),
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

  Widget servicioTarjeta(IconData icon, String text, double size) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, size: size),
        title: Text(text),
      ),
    );
  }

  Widget precioItem(String dayType, String price, Color color) {
    return ListTile(
      title: Text(dayType),
      trailing: Text(
        '\$' + price,
        style: TextStyle(color: color, fontSize: 18),
      ),
    );
  }
}
