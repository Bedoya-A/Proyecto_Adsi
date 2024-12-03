import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/Menu.dart';
import 'package:prueba2/FloatingActionMenu.dart';
import 'package:url_launcher/url_launcher.dart'; // Ensure the path is correct

class CabanaLaMontana extends StatefulWidget {
  @override
  _CabanaLaMontanaState createState() => _CabanaLaMontanaState();
}

class _CabanaLaMontanaState extends State<CabanaLaMontana> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int selectedDrawerIndex = 1;
  double _rating = 0; // Initial rating value
  TextEditingController _reviewController = TextEditingController();

  // List to store reviews
  List<Map<String, dynamic>> _reviews = [];

  final List<String> imgList = [
    'assets/montaña1.png',
    'assets/montaña2.png',
    'assets/montaña3.png',
    'assets/montaña4.png',
    'assets/montaña5.png',
  ];
  int _current = 0;

  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
  }

  Future<void> _openMap() async {
    const url =
        'https://maps.app.goo.gl/47jiTafrHd3NBNKN9'; // Reemplaza con la URL de tu ubicación
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el mapa: $url';
    }
  }

  Future<void> _launchYoutube() async {
    const url = 'https://youtu.be/ev2h6MBlMhM';
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

  // Function to remove review
  void _removeReview(int index) {
    setState(() {
      _reviews.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cabaña la Montaña', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff8b4513),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icono para retroceder
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context)
                    .openEndDrawer(); // Open the right-side menu
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
        color: Color(0xffd2b48c),
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
                  '¡Un lugar mágico donde la naturaleza te envuelve! \n\n'
                  'La Montaña te ofrece una experiencia inolvidable, perfecta para aventureros que buscan tranquilidad y conexión con la naturaleza. '
                  'Descubre las vistas más impresionantes de Ibagué y respira el aire puro de las alturas. ¡Es un refugio que te recargará de energía!',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),

                // Distancia
                Card(
                  child: Text(
                    ' A solo 10 minutos de la Universidad de Ibagué en el barrio Ambalá',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10), // Espacio entre el texto y la imagen

                // Sección de servicios
                buildServiciosSection(),

                // Sección de precios, senderismo, desayuno
                buildInfoSection(),
                SizedBox(height: 30),
                // Sección de reseñas
                _buildReviewForm(context)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionMenu(
        siteName: "Cabaña la Montaña", // Nombre del sitio
        mapUrl:
            "https://maps.app.goo.gl/47jiTafrHd3NBNKN9", // URL del mapa (Waze o Google Maps)
        onPressed: () {
          _openMap(); // Acción al presionar el botón para abrir el mapa
        },
      ),
    );
  }

  // Método para construir la sección de servicios
  Widget buildServiciosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          ' SERVICIOS ',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff2e8b57),
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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider(
                items: imgList
                    .map((item) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(item,
                                fit: BoxFit.cover, width: 1000),
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
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 101, 161, 154), // Color del botón
              ),
            ),
          ),
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
          title: ' PRECIOS',
          content: '• Lunes a Jueves: \$60.000 por noche\n'
              '• Viernes o Domingos: \$70.000 por noche\n'
              '• Sábados o día antes de festivo: \$100.000 por noche',
        ),
        infoCard(
          title: ' SENDERISMO',
          content:
              '30 minutos (1.2 km) desde la entrada del parque hasta la cabaña.',
        ),
        infoCard(
          title: ' DESAYUNO OPCIONAL',
          content:
              'Huevos al gusto, patacón, arroz, café o chocolate (10.000 adicionales).',
        ),
      ],
    );
  }

  Widget servicioTarjeta(IconData icono, String texto, double fontSize) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      elevation: 4.0,
      child: ListTile(
        leading: Icon(icono, size: 30, color: Color(0xffd2b48c)),
        title: Text(
          texto,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xff2e8b57),
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

  Widget infoCard({required String title, required String content}) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff2e8b57),
          ),
        ),
        subtitle: Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildReviewForm(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30), // Espaciado adicional
              // Sección de reseñas
              _buildSectionTitle("DEJA TU RESEÑA", Icons.star_rate),
              SizedBox(height: 20), // Separación adicional
              _buildStarRating(),
              SizedBox(height: 20), // Separación adicional
              TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  labelText: 'Escribe tu reseña',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 10),
              Center(
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
          ),
        ),
      ),
    );
  }
}
