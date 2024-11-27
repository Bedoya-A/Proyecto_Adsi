import 'package:flutter/material.dart';

class NoMeInteresaPage extends StatefulWidget {
  @override
  _NoMeInteresaPageState createState() => _NoMeInteresaPageState();
}

class _NoMeInteresaPageState extends State<NoMeInteresaPage> {
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
                      print("Le diste like a $title");
                    },
                  ),
                  // Botón de comentar
                  IconButton(
                    icon: Icon(Icons.comment, color: Colors.cyanAccent),
                    onPressed: _showCommentDialog,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                print("Comentario: ${commentController.text}");
                Navigator.of(context).pop();
              },
              child: Text(
                'Enviar',
                style: TextStyle(color: Colors.cyanAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
          'No Me Interesa',
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
            _buildItemCard("Jardin Botanico", "no despiertan interés.",
                'assets/eventos.jpg'),
            _buildItemCard(
                "Parque Meraki.", "Pesimo Servicio.", 'assets/meraki4.png'),
            _buildItemCard(
                "Cabaña Paraiso", "nada atrativo.", 'assets/paraiso.jpg'),
            _buildItemCard("Mirador Tesorito", "sin vistas emocionantes.",
                'assets/tesorito2.jpg'),
            SizedBox(height: 20),
            _buildInterestSection(), // Sección "Cosas que No Me Interesan"
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

  // Sección dinámica de "Cosas que No Me Interesan"
  Widget _buildInterestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cosas que No Me Interesan",
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
                  "Cabaña Montaña",
                  "Exposiciones que no despiertan interés.",
                  'assets/montaña4.png'),
              _buildInterestCard(
                  "Autoctonos",
                  "Sin actividades ni entretenimiento.",
                  'assets/autoctonos1.jpg'),
              _buildInterestCard("Cabaña arbol",
                  "El lugar necesita más cuidado.", 'assets/arbol4.png'),
              _buildInterestCard("Parque Meraki",
                  "Faltaron actividades interesantes.", 'assets/meraki1.png'),
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
              // Imagen de ejemplo
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
