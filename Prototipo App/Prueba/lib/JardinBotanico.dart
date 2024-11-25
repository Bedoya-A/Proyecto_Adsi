import 'package:flutter/material.dart';
import 'package:prueba2/FormularioReserva.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/FloatingActionMenu.dart';
import 'package:prueba2/PaginaOferta.dart';
import 'package:prueba2/ServiciosJardinBotanico.dart';
import 'package:prueba2/ZoomImagen.dart';
import 'package:prueba2/menu.dart';
import 'package:url_launcher/url_launcher.dart';

class JardinBotanico extends StatefulWidget {
  @override
  State<JardinBotanico> createState() => _JardinBotanicoState();
}

class _JardinBotanicoState extends State<JardinBotanico>
    with TickerProviderStateMixin {
  bool _isHomeIconVisible = false;
  late TabController _tabController;
  double _rating = 0; // Initial rating value
  TextEditingController _reviewController = TextEditingController();
  List<Map<String, dynamic>> _reviews = [];

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

  Future<void> _openMap() async {
    const url =
        'https://maps.app.goo.gl/NG9R3FtTVJwmnVGs7'; // Reemplaza con la URL de tu ubicación
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el mapa: $url';
    }
  }

  Future<void> _launchYoutube() async {
    const url = 'https://youtu.be/7CdXUBEqdIU';
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

  void _showReservationForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ReservationForm(
            onSubmit: (name, phone, date, numPeople) {
              // Lógica para manejar la reserva
              print('Reserva: $name, $phone, $date, $numPeople');
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Jardín Botánico'),
            Tab(text: 'Servicios'),
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
          _buildJardinBotanicoContent(),
          ServiciosJardinBotanico(),
        ],
      ),
      floatingActionButton: FloatingActionMenu(
        siteName: "Jardín Botanico San Jorge", // Nombre del sitio
        mapUrl:
            "https://maps.app.goo.gl/NG9R3FtTVJwmnVGs7", // URL del mapa (Waze o Google Maps)
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
            child: Center(
          child: Text(
            'Jardín Botánico',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white // Para el modo oscuro
                  : Colors.black, // Para el modo claro
              fontSize: 20,
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
        )),
      ],
    );
  }

  Widget _buildJardinBotanicoContent() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 10),
            _buildDescription(),
            SizedBox(height: 20),
            _buildSectionTitleText("60 Hectáreas Llenas de Magia"),
            SizedBox(height: 10),
            _buildMagicDescription(),
            SizedBox(height: 20),
            _buildExplorationZones(),
            SizedBox(height: 30),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: _launchYoutube,
                  icon: Icon(Icons.video_library,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                  label: Text(
                    "Ver video en YouTube",
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 101, 161, 154), // Color del botón
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Espacio horizontal
              child:
                  _buildSectionTitleWithIcon("DEJA TU RESEÑA", Icons.star_rate),
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
            // Mostrar las reseñas con opción de eliminar
            Column(
              children: _reviews.map((review) {
                int index = _reviews.indexOf(review); // Obtener índice
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 5),
                        Text('${review['rating']} estrellas'),
                      ],
                    ),
                    subtitle: Text(review['review']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _reviews.removeAt(index); // Eliminar reseña
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        )));
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        'JARDÍN BOTÁNICO SAN JORGE',
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green[900]),
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'El Jardín Botánico San Jorge se localiza en los cerros noroccidentales de Ibagué en el Departamento del Tolima. '
          'Se encuentra ubicado en la antigua Granja San Jorge, vía Calambeo, a cinco minutos del centro de la ciudad.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10), // Espacio entre el texto y la imagen
      ],
    );
  }

  Widget _buildMagicDescription() {
    return Text(
      'Para el contacto vivencial con la naturaleza, el Jardín Botánico San Jorge cuenta con una extensión de 60 hectáreas, '
      'distribuidas en tres espacios, surcados por senderos ecológicos, organizados en circuitos, sobre los que se desarrollan diversos temas de estudio:',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildExplorationZones() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildImageCard('assets/insitu.jpeg', 'In Situ',
            'Alberga un bosque natural sub andino de la reserva forestal San Jorge.'),
        SizedBox(height: 10),
        _buildImageCard('assets/exsitu.jpeg', 'Ex Situ',
            'Donde habitan las colecciones de plantas vivas.'),
        SizedBox(height: 10),
        _buildImageCard('assets/arboretum.jpeg', 'Arboretum',
            'Donde se pueden encontrar los árboles más representativos del departamento.'),
      ],
    );
  }

  // Método que solo recibe el título
  Widget _buildSectionTitleText(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[900]),
    );
  }

// Método que recibe el título y el ícono
  Widget _buildSectionTitleWithIcon(String title, IconData icon) {
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

  Widget _buildImageCard(String imagePath, String title, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ImageZoomScreen(imagePath: imagePath)),
        );
      },
      child: Card(
        child: Column(
          children: [
            Image.asset(imagePath),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
