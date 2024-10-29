import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Asegúrate de agregar esta línea en tu pubspec.yaml
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/PaginaOferta.dart';

class MiradorTesorito extends StatefulWidget {
  @override
  _MiradorTesoritoState createState() => _MiradorTesoritoState();
}

class _MiradorTesoritoState extends State<MiradorTesorito>
    with TickerProviderStateMixin {
  bool _isHomeIconVisible = false;
  List<AnimationController> _controllers = [];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateStartController = TextEditingController();
  final _dateEndController = TextEditingController();
  final _numPeopleController = TextEditingController();
  int selectedDrawerIndex = 1;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _nameController.dispose();
    _phoneController.dispose();
    _dateStartController.dispose();
    _dateEndController.dispose();
    _numPeopleController.dispose();
    super.dispose();
  }

  void _selectDate(TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      controller.text = formattedDate;
    }
  }

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible = !_isHomeIconVisible;
    });
  }

  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaginaOferta()),
      );
    }
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
            SizedBox(width: 10), // Espaciado entre el logo y el título
            Flexible(
              child: Text(
                'Mirador Tersorito',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
        selectedDrawerIndex: 0, // Usa el índice actual
        onSelectDrawerItem: (int index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PaginaOferta()),
            );
          }
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 70, 254, 236),
              Color.fromARGB(255, 199, 245, 223)
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(),
              SizedBox(height: 20),
              _buildTitleSection('Cocina y vistas increíbles'),
              _buildDescriptionSection(
                  'Disfruta de una experiencia única en nuestro restaurante con vistas al paisaje montañoso y una cocina exquisita.'),
              SizedBox(height: 20),
              _buildInteractiveCards(context),
              SizedBox(height: 20),
              Divider(color: Colors.teal, thickness: 2), // Divider para separar
              _buildMenuSection(), // Sección de menú
              Divider(color: Colors.teal, thickness: 2), // Divider
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.6),
                child: _buildSectionTitle("Reserva tu experiencia"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.6),
                child: Form(
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
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción de reserva
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.book_online),
      ),
    );
  }

  // Sección de encabezado con imagen
  Widget _buildHeaderSection() {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tesorito.jpg'), // Imagen adecuada
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.5), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            'Mirador Tesorito',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  offset: Offset(3, 3),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Sección de título destacada
  Widget _buildTitleSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Cambia el color a blanco
          shadows: [
            Shadow(
              color: Colors.black45,
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ], // Sombra para hacerlo más llamativo
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Sección de descripción
  Widget _buildDescriptionSection(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        description,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Sección interactiva con tarjetas llamativas
  Widget _buildInteractiveCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildInfoCard(
            'El mirador Tesorito está operando hace dos años. El propietario es Yeison Ramirez. Ofrece servicios de mirador y restaurante.',
            Icons.place,
            Colors.orange,
          ),
          _buildInfoCard(
            'Horarios: \nLunes a Viernes: 3:00 pm - 11:00 pm\nSábados, Domingos y Festivos: 11:00 am - 11:00 pm',
            Icons.access_time,
            Colors.blue,
          ),
          _buildInfoCard(
            'Pagos disponibles por Nequi y Daviplata.',
            Icons.attach_money,
            Colors.green,
          ),
          _buildInfoCard(
            'Costo de ingreso: 5,000 COP (incluye bebida de bienvenida).',
            Icons.local_drink,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  // Tarjeta de información interactiva
  Widget _buildInfoCard(String text, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // Sección del menú con separaciones
  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection('Menú de Comida'), // Título del menú
          SizedBox(height: 20),
          _buildAnimatedMenuSection(
              0,
              'Entradas',
              [
                'Porción huevos de codorniz (7 unid) - 5.000 COP',
                'Porción pataconas (3 unid) - 5.000 COP',
                'Porciones papas a la francesa - 5.000 COP',
                'Pataconas con pollo y carne desmechada (2 unid) - 10.000 COP',
              ],
              Icons.food_bank),
          Divider(), // Divider entre las secciones
          _buildAnimatedMenuSection(
              1,
              'Platos a la Carta',
              [
                'Pechuga a la plancha (300g) - 30.000 COP',
                'Lomo de cerdo a la plancha (300g) - 28.000 COP',
                'Churrasco a la plancha (300g) - 32.000 COP',
                'Mojarra frita (500g) - 30.000 COP',
              ],
              Icons.local_dining),
          Divider(),
          _buildAnimatedMenuSection(
              2,
              'Comidas Rápidas',
              [
                'Choripapa - 20.000 COP',
                'Salchipapa - 18.000 COP',
                'Hamburguesa de pollo - 18.000 COP',
                'Super perro - 20.000 COP',
              ],
              Icons.fastfood),
          Divider(),
          _buildAnimatedMenuSection(
              3,
              'Bebidas Calientes',
              [
                'Aguapanela con queso - 6.000 COP',
                'Chocolate con queso - 8.000 COP',
                'Tinto - 1.500 COP',
              ],
              Icons.local_cafe),
          Divider(),
          _buildAnimatedMenuSection(
              4,
              'Bebidas Frías',
              [
                'Limonada de coco - 9.000 COP',
                'Cerveza personal - 9.000 COP',
                'Frappe de café - 12.000 COP',
              ],
              Icons.icecream),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      TextInputType keyboardType, IconData icon,
      {VoidCallback? onTap}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onTap: onTap,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingresa $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  // Menú con animación en el ícono de despliegue
  Widget _buildAnimatedMenuSection(
      int index, String title, List<String> items, IconData icon) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(icon, color: Colors.teal[700]),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Color de título en blanco
              shadows: [
                Shadow(
                  color: Colors.black45,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ], // Sombra para hacerlo más llamativo
            ),
          ),
        ],
      ),
      trailing: RotationTransition(
        turns: Tween(begin: 0.0, end: 0.5).animate(_controllers[index]),
        child: Icon(
          Icons.expand_more,
          color: Colors.teal[700],
        ),
      ),
      onExpansionChanged: (isExpanded) {
        setState(() {
          if (isExpanded) {
            _controllers[index].forward();
          } else {
            _controllers[index].reverse();
          }
        });
      },
      children: items.map((item) {
        return ListTile(
          title: Text(item),
          leading: Icon(Icons.check, color: Colors.teal),
        );
      }).toList(),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.teal[900],
      ),
    ),
  );
}
