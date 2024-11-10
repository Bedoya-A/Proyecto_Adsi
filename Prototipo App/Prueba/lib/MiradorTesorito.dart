import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/PaginaOferta.dart';
import 'package:url_launcher/url_launcher.dart';

class MiradorTesorito extends StatefulWidget {
  @override
  _MiradorTesoritoState createState() => _MiradorTesoritoState();
}

class _MiradorTesoritoState extends State<MiradorTesorito>
    with TickerProviderStateMixin {
  bool _isHomeIconVisible = false;
  List<AnimationController> _controllers = [];

  int selectedDrawerIndex = 1;
  double _rating = 0; // Initial rating value
  TextEditingController _reviewController = TextEditingController();
  List<Map<String, dynamic>> _reviews = [];

  final List<String> imgList = [
    'assets/tesorito1.jpg',
    'assets/tesorito2.jpg',
    'assets/tesorito3.jpg',
    'assets/tesorito4.jpg',
    'assets/tesorito5.jpg',
  ];

  int _current = 0;

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

  Future<void> _launchYoutube() async {
    const url = 'https://youtube.com/shorts/ZwwYu4h6BSQ?feature=share';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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

  void _removeReview(int index) {
    setState(() {
      _reviews.removeAt(index);
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
                  _onLogoTap();
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
            SizedBox(width: 10),
            Flexible(
              child: Text(
                'Mirador Tesorito',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Menu(
        selectedDrawerIndex: 0,
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
              Color.fromARGB(255, 199, 245, 223),
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
              Divider(color: Colors.teal, thickness: 2),
              _buildMenuSection(),
              Divider(color: Colors.teal, thickness: 2),
              SizedBox(height: 20),
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
                      viewportFraction: 0.33,
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
                    icon: Icon(Icons.video_library,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    label: Text(
                      "Ver video en YouTube",
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 101, 161, 154), // Color del botón
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0), // Espacio horizontal
                child: _buildSectionTitle("DEJA TU RESEÑA", Icons.star_rate),
              ),
              SizedBox(height: 20), // Separación adicional
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildStarRating(),
              ),
              SizedBox(height: 20), // Separación adicional
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _reviewController,
                  decoration: InputDecoration(
                    labelText: 'Escribe tu reseña',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
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
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

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
  );
}

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
