import 'package:flutter/material.dart';
import 'package:prueba2/Cabanas.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/FloatingActionMenu.dart';
import 'package:prueba2/PaginaOferta.dart';
import 'package:prueba2/menu.dart';
import 'package:url_launcher/url_launcher.dart';

class ParaisoEscondido extends StatefulWidget {
  @override
  State<ParaisoEscondido> createState() => _ParaisoEscondidoState();
}

class _ParaisoEscondidoState extends State<ParaisoEscondido>
    with TickerProviderStateMixin {
  bool _isHomeIconVisible = false;
  late TabController _tabController;

  int selectedDrawerIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible = !_isHomeIconVisible;
    });
  }

  Future<void> _openMap() async {
    const url =
        'https://maps.app.goo.gl/zwJHJA3pbCqH6BUo6'; // Reemplaza con la URL de tu ubicación
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el mapa: $url';
    }
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
      backgroundColor: Color(0xFFD2B48C), // Beige Arena
      appBar: AppBar(
        title: _buildAppBarTitle(),
        backgroundColor: Color(0xFF8B4513), // Marrón Madera
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(0xFF2E8B57), // Verde Pino
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Información General'),
            Tab(text: 'Cabañas'),
          ],
        ),
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
        selectedDrawerIndex: selectedDrawerIndex,
        onSelectDrawerItem: onSelectDrawerItem,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildParaisoEscondidoDescription(),
          Cabanas(),
        ],
      ),
      floatingActionButton: FloatingActionMenu(
        siteName: "Paraiso Escondido", // Nombre del sitio
        mapUrl:
            "https://maps.app.goo.gl/47jiTafrHd3NBNKN9", // URL del mapa (Waze o Google Maps)
        onPressed: () {
          _openMap(); // Acción al presionar el botón para abrir el mapa
        },
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
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
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: _isHomeIconVisible
                  ? Icon(Icons.home,
                      key: ValueKey('homeIcon'), size: 40, color: Colors.white)
                  : CircleAvatar(
                      key: ValueKey('jardinLogo'),
                      radius: 20,
                      backgroundImage: AssetImage('assets/logo.png')),
            ),
          ),
        ),
        SizedBox(width: 10),
        Flexible(
          child: Text(
            'Paraiso Escondido',
            style: TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

Widget _buildParaisoEscondidoDescription() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/paraiso.jpg'), // Imagen de fondo
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 200,
              color: Colors.black.withOpacity(0.5), // Efecto de oscurecimiento
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  '¡Bienvenido a Paraíso Escondido!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'La Experiencia',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E8B57), // Verde Pino
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Imagina un lugar donde la naturaleza y el confort se fusionan en perfecta armonía. '
                'Paraíso Escondido no es solo un destino, es una experiencia inolvidable que invita a desconectarte del bullicio y reconectar con lo esencial.',
                style:
                    TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Lo que ofrecemos:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF8B4513),
                ),
              ),
              SizedBox(height: 10),
              _buildFeatureTile(
                icon: Icons.landscape,
                title: 'Vistas Panorámicas',
                description:
                    'Disfruta de paisajes que te quitarán el aliento y llenarán tu corazón de paz.',
                titleColor: const Color(0XFF8B4513),
                descriptionColor: Colors.black, // Color de la descripción
              ),
              _buildFeatureTile(
                icon: Icons.hiking,

                title: 'Senderos Naturales',
                description:
                    'Explora senderos rodeados de flora y fauna autóctona, ideales para caminatas y aventuras.',
                titleColor: Color(0XFF8B4513), // Color del título
                descriptionColor: Colors.black, // Color de la descripción
              ),
              _buildFeatureTile(
                icon: Icons.king_bed,
                title: 'Cabañas Exclusivas',
                description:
                    'Relájate en cabañas rústicas con todas las comodidades modernas para una estancia inolvidable.',
                titleColor: Color(0XFF8B4513), // Color del título
                descriptionColor: Colors.black, // Color de la descripción
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4B3621)
                      .withOpacity(0.1), // Fondo Café rústico translúcido
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    ' ¡Ven y vive la magia del Paraíso Escondido! ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFeatureTile({
  required IconData icon,
  required String title,
  required String description,
  required Color titleColor, // Parámetro para el color del título
  required Color descriptionColor, // Parámetro para el color de la descripción
}) {
  return ListTile(
    leading: Icon(icon),
    iconColor: Colors.black,
    title: Text(
      title,
      style: TextStyle(color: titleColor), // Aplicar color al título
    ),
    subtitle: Text(
      description,
      style:
          TextStyle(color: descriptionColor), // Aplicar color a la descripción
    ),
  );
}
