import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/PaginaOferta.dart';
import 'Menu.dart'; // Importa el menú que creaste
import 'package:url_launcher/url_launcher.dart';

class Autoctonos extends StatefulWidget {
  @override
  _AutoctonosState createState() => _AutoctonosState();
}

class _AutoctonosState extends State<Autoctonos> {
  bool _isHomeIconVisible =
      false; // Variable para controlar la visibilidad del ícono

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _numPeopleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> imgList = [
    'assets/autoctonos1.jpg', // Reemplaza con las rutas de tus imágenes
    'assets/autoctonos2.jpg',
    'assets/autoctonos3.jpg',
    'assets/autoctonos4.jpg',
    'assets/autoctonos5.jpg', // Agregué más imágenes para que se vea el deslizamiento
  ];

  int _current = 0;

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
    const url = 'https://youtu.be/yJMtFwHefzY';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    // Limpia los controladores de texto para liberar recursos
    _nameController.dispose();
    _phoneController.dispose();
    _dateStartController.dispose();
    _dateEndController.dispose();
    _numPeopleController.dispose();
    super.dispose();
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
                onTap: _onLogoTap,
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
                      : const CircleAvatar(
                          key: ValueKey('logoIcon'),
                          radius: 20,
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 10), // Espaciado entre el logo y el título
            const Flexible(
              child: Text(
                'Autóctonos',
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
              icon: const Icon(Icons.menu),
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
              MaterialPageRoute(builder: (context) => const PaginaOferta()),
            );
          }
        },
      ),
      body: Stack(
        children: [
          _buildBackgroundGradient(),
          _buildBanner(),
          _buildContent(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Llamando al mirador...');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.phone, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBackgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.teal[200]!,
            Colors.teal[400]!,
            Colors.teal[600]!,
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/autoctonos.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 16, bottom: 16),
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.teal.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Text(
          'Mirador Autoctonos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 2,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 220),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShortDescription(),
            SizedBox(height: 20),
            _buildSections(),
            SizedBox(height: 20),
            _buildMenu(),
            SizedBox(height: 20),
            _buildReservationForm(context),
            SizedBox(height: 20),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildShortDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        'Disfruta de vistas impresionantes y sabores auténticos. '
        'Un espacio perfecto para conectar con la naturaleza y saborear lo mejor de la tradición rural.',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSections() {
    return Column(
      children: [
        _buildSection('Ubicación', 'Vereda Alcon Tesorito, Ibagué'),
        _buildSection(
          'Desde cuando inició este mirador',
          'Este increíble y maravilloso mirador comenzó a operar en mayo de 2024.',
        ),
        _buildSection(
          'Servicios',
          '• Restaurante sábados, domingos y festivos de 11:00 AM a 10:00 PM\n'
              '• Reservas con dos días de anticipación\n'
              '• Celebraciones especiales\n'
              '• Servicio a domicilio fines de semana',
        ),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.teal[800],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Positioned(
                top: 2,
                left: 2,
                child: Text(
                  'Nuestro MENÚ',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
              Text(
                'Nuestro MENÚ',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text('Almuerzos desde \$15.000', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        _buildMenuList(),
      ],
    );
  }

  Widget _buildMenuList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExpandableMenuSection('Carnes Rojas', [
          '✔ Punta de Anca - \$30.000\n  Arroz primavera, papa a la francesa y ensalada',
          '✔ Lomo de Cerdo - \$28.000\n  Arroz primavera, papas a la francesa y ensalada',
          '✔ Costilla BBQ - \$28.000\n  Arroz primavera, papa a la francesa y ensalada',
          '✔ Sobrebarriga al Horno - \$28.000\n  Arroz primavera, papas a la francesa y ensalada',
          '✔ Plato Fuerte a la Parrilla - \$22.000\n  Arroz, rellena, yuca, envuelto de maíz y ensalada',
          '✔ Churrasco - \$28.000\n  Ensalada y chimichurri',
          '✔ Salchicharpa - \$20.000\n  Papa salada, arepa, y ensalada',
          '✔ Salchipapa - \$15.000\n  Francés americana, papas a la francesa y salchipapa.',
        ]),
        _buildExpandableMenuSection('Carnes Blancas', [
          '✔ Gordon Blue - \$20.000\n  Arroz primavera, papas a la francesa, ensalada rusa.',
        ]),
        _buildExpandableMenuSection('Mar', [
          '✔ Mojarra Frita - \$25.000\n  Arroz primavera, papas a la francesa y ensalada.',
          '✔ Bagre en Salsa - \$40.000\n  Arroz primavera, papa, yuca y aguacate.',
          '✔ Camarón en Mantequilla - \$24.000\n  Frutos del mar acompañado de patacones.',
        ]),
        _buildExpandableMenuSection('Bebidas', [
          '✔ Gaseosa',
          '✔ Jugos',
          '✔ Agua',
          '✔ Cerveza Corona',
          '✔ Cerveza Costeña',
          '✔ Águila',
          '✔ Poker',
          '✔ Y mucho más...',
        ]),
        Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider(
              items: imgList
                  .map((item) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction:
                    0.33, // Esto permite ver tres imágenes a la vez
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
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
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
                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _current = (_current + 1) % imgList.length;
                  });
                },
              ),
            ),
          ],
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _launchYoutube,
              icon: Icon(Icons.video_library, color: Colors.white),
              label: Text(
                "Ver video en YouTube",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Color del botón
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoLink() {
    return GestureDetector(
      onTap: () {
        launchUrl(
            Uri.parse('https://youtube.com/shorts/ZwwYu4h6BSQ?feature=share'));
      },
      child: Text(
        "Ver video del Mirador Tesorito",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildExpandableMenuSection(String title, List<String> items) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        leading: Icon(Icons.local_dining, color: Colors.teal, size: 30),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Text(item, style: TextStyle(fontSize: 16)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReservationForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reserva tu mesa',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                SizedBox(height: 10),
                _buildTextField(_nameController, 'Nombre', Icons.person),
                SizedBox(height: 10),
                _buildTextField(_phoneController, 'Teléfono', Icons.phone),
                SizedBox(height: 10),
                _buildTextField(
                    _dateStartController, 'Fecha Inicio', Icons.date_range),
                SizedBox(height: 10),
                _buildTextField(
                    _dateEndController, 'Fecha Fin', Icons.date_range),
                SizedBox(height: 10),
                _buildTextField(
                    _numPeopleController, 'Número de Personas', Icons.group),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showReservationDialog(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      'Reservar',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.teal[700]),
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese $labelText';
        }
        return null;
      },
    );
  }

  void _showReservationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reserva Exitosa'),
          content: Text(
              'Tu reserva ha sido realizada con éxito. Nos pondremos en contacto contigo pronto.'),
          actions: <Widget>[
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
  }

  Widget _buildFooter() {
    return Center(
      child: Text(
        'Te esperamos en el Mirador Autoctonos!',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
