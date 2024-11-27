import 'package:flutter/material.dart';

class MeInteresaPage extends StatefulWidget {
  @override
  _MeInteresaPageState createState() => _MeInteresaPageState();
}

class _MeInteresaPageState extends State<MeInteresaPage> {
  // Función para mostrar el cuadro de diálogo
  void _showDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text(
            title,
            style: TextStyle(color: Colors.cyanAccent),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                description,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Botón de like
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.redAccent),
                    onPressed: () {
                      // Lógica para darle like
                      print("Le diste like a $title");
                    },
                  ),
                  // Botón de comentar
                  IconButton(
                    icon: Icon(Icons.comment, color: Colors.cyanAccent),
                    onPressed: () {
                      // Lógica para mostrar campo de comentario o redirigir
                      _showCommentDialog();
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
              child: Text(
                'Cerrar',
                style: TextStyle(color: Colors.cyanAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  // Función para mostrar el cuadro de comentario
  void _showCommentDialog() {
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text(
            "Deja un Comentario",
            style: TextStyle(color: Colors.cyanAccent),
          ),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: "Escribe tu comentario...",
              hintStyle: TextStyle(color: Colors.white54),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyanAccent),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Lógica para guardar o procesar el comentario
                print("Comentario: ${commentController.text}");
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
              child: Text(
                'Enviar',
                style: TextStyle(color: Colors.cyanAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.cyanAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Me Interesa',
          style: TextStyle(color: Colors.cyanAccent),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade900, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildItemCard(
                "Paraíso Escondido",
                "Un hermoso lugar para conectar con la naturaleza.",
                'assets/paraiso4.png'),
            _buildItemCard(
                "Meraki",
                "Un destino lleno de paz y belleza natural.",
                'assets/meraki2.png'),
            _buildItemCard(
                "Autóctonos",
                "Conoce la cultura local y sus tradiciones.",
                'assets/autoctonos2.jpg'),
            _buildItemCard(
                "Mirador Tesorito",
                "Un lugar espectacular con vistas panorámicas.",
                'assets/tesorito3.jpg'),
            SizedBox(height: 20),
            _buildInterestSection(), // Mover esta sección aquí, al final
          ],
        ),
      ),
    );
  }

  // Widget para el encabezado de la sección
  Widget _buildHeader() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.cyanAccent, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            "Explora lo Mejor",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Encuentra lugares fascinantes para disfrutar y explorar.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Sección dinámica de "Cosas que te Pueden Interesar"
  Widget _buildInterestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cosas que te Pueden Interesar",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.cyanAccent,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildInterestCard(
                  "Jardín Botánico",
                  "Explora la belleza y tranquilidad de un jardín lleno de vida.",
                  'assets/senderismo.jpg'),
              _buildInterestCard(
                  "Cabaña Paraíso",
                  "Escápate a la cabaña más relajante, en el corazón de la naturaleza.",
                  'assets/paraiso5.png'),
              _buildInterestCard(
                  "Cabaña Montaña",
                  "Conéctate con las montañas y disfruta de la serenidad.",
                  'assets/montaña5.png'),
              _buildInterestCard(
                  "Parque Meraki",
                  "Un espacio para relajarte y disfrutar de la naturaleza en su estado más puro.",
                  'assets/meraki4.png'),
            ],
          ),
        ),
      ],
    );
  }

  // Tarjeta dinámica de interés
  Widget _buildInterestCard(
      String title, String description, String imagePath) {
    return GestureDetector(
      onTap: () => _showDialog(title, description),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.blueGrey.shade800,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.black45, // Fondo oscuro semitransparente
                  padding: EdgeInsets.all(8),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  color: Colors.black45, // Fondo oscuro semitransparente
                  padding: EdgeInsets.all(8),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
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

  // Widget para crear una tarjeta de cada sitio
  Widget _buildItemCard(String title, String description, String imagePath) {
    return GestureDetector(
      onTap: () => _showDialog(
          title, description), // Al hacer clic, abrir el cuadro de diálogo
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        color: Colors.blueGrey.shade800,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Imagen de ejemplo (puedes poner una imagen real aquí)
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(width: 16),
              // Título y descripción
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
