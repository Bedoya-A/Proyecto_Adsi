import 'package:flutter/material.dart';
import 'package:prueba2/RecentSearchPage.dart';

class TuActividadPage extends StatefulWidget {
  @override
  _TuActividadPageState createState() => _TuActividadPageState();
}

class _TuActividadPageState extends State<TuActividadPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  bool showMeInteresa = false; // Control para mostrar/ocultar "Me interesa"
  bool showNoMeInteresa =
      false; // Control para mostrar/ocultar "No me interesa"
  List<int> likes = List.filled(6, 0); // Contador de likes por tarjeta
  List<String> comentarios = List.filled(6, ""); // Comentarios por tarjeta
  List<String> descripciones = [
    'Descripción llamativa de la actividad 1',
    'Descripción llamativa de la actividad 2',
    'Descripción llamativa de la actividad 3',
    'Descripción llamativa de la actividad 4',
    'Descripción llamativa de la actividad 5',
    'Descripción llamativa de la actividad 6',
  ]; // Descripciones para las tarjetas
  List<int> noMeInteresaLikes =
      List.filled(6, 0); // Contador de "No me interesa"
  List<String> noMeInteresaComentarios =
      List.filled(6, ""); // Comentarios de "No me interesa"

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.cyanAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tu Actividad',
          style: TextStyle(
            color: Colors.cyanAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blueGrey.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kToolbarHeight + 20),
                _buildFuturisticHeader(),
                SizedBox(height: 30),
                _buildAnimatedSection(
                  'Contenido sugerido',
                  [
                    _buildOption(Icons.visibility_off, 'No me interesa', true),
                    _buildOption(Icons.visibility, 'Me interesa', true),
                  ],
                ),
                if (showMeInteresa) ...[
                  SizedBox(height: 20),
                  _buildMeInteresaSection(),
                ],
                if (showNoMeInteresa) ...[
                  SizedBox(height: 20),
                  _buildNoMeInteresaSection(),
                ],
                SizedBox(height: 30),
                _buildAnimatedSection(
                  'Cómo usas la aplicación',
                  [
                    _buildOption(Icons.access_time, 'Tiempo en la app'),
                    _buildOption(
                        Icons.calendar_today, 'Historial de la cuenta'),
                    _buildOption(Icons.search, 'Búsquedas recientes'),
                    _buildOption(Icons.link, 'Historial de enlaces'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFuturisticHeader() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Column(
          children: [
            Text(
              'Controla tu actividad',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Explora y administra lo que te importa.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(String title, List<Widget> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideTransition(
          position: Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
              .animate(CurvedAnimation(
                  parent: _controller, curve: Curves.easeInOut)),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(height: 10),
        ...options,
      ],
    );
  }

  Widget _buildOption(IconData icon, String title, [bool toggle = false]) {
    return GestureDetector(
      onTap: () {
        if (title == 'Me interesa') {
          setState(() {
            showMeInteresa = !showMeInteresa;
          });
        } else if (title == 'No me interesa') {
          setState(() {
            showNoMeInteresa = !showNoMeInteresa;
          });
        } else if (title == 'Búsquedas recientes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecentSearchPage()),
          );
        }
        // Otras opciones pueden agregarse aquí con lógica similar
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade800, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
            border: Border.all(color: Colors.cyanAccent, width: 2),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.black, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.cyanAccent, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeInteresaSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.6),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¡Me interesa! 💬',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
            ),
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return _buildCard(index, likes, comentarios, true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoMeInteresaSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.6),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No me interesa 💬',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return _buildCard(
                  index, noMeInteresaLikes, noMeInteresaComentarios, false);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(int index, List<int> likesList,
      List<String> comentariosList, bool isMeInteresa) {
    TextEditingController comentarioController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey.shade700, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.6),
            blurRadius: 8,
            spreadRadius: 4,
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/imagen_$index.jpg', // Asegúrate de tener imágenes en la carpeta assets
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            descripciones[index],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up, color: Colors.white),
                onPressed: () {
                  setState(() {
                    likesList[index]++;
                  });
                },
              ),
              Text(
                '${likesList[index]} Likes',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Campo para añadir comentarios
          TextField(
            controller: comentarioController,
            onChanged: (value) {
              setState(() {
                comentariosList[index] = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Añadir un comentario...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              fillColor: Colors.white.withOpacity(0.2),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          // Mostrar el comentario si existe
          comentariosList[index].isNotEmpty
              ? Row(
                  children: [
                    Text(
                      comentariosList[index],
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          comentariosList[index] = ""; // Elimina el comentario
                        });
                      },
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
