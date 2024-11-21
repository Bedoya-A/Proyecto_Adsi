import 'package:flutter/material.dart';

class TuActividadPage extends StatefulWidget {
  @override
  _TuActividadPageState createState() => _TuActividadPageState();
}

class _TuActividadPageState extends State<TuActividadPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

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
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.blueGrey.shade900,
                ],
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
                        _buildOption(Icons.visibility_off, 'No me interesa'),
                        _buildOption(Icons.visibility, 'Me interesa'),
                      ],
                    ),
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
          );
        },
      ),
    );
  }

  Widget _buildFuturisticHeader() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.6),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
                gradient: SweepGradient(
                  colors: [
                    Colors.cyanAccent,
                    Colors.blueAccent,
                    Colors.cyanAccent.withOpacity(0.5),
                  ],
                  stops: [0.2, 0.6, 1.0],
                ),
              ),
              child: Icon(Icons.star, size: 60, color: Colors.black),
            ),
            SizedBox(height: 20),
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
          position: Tween<Offset>(
            begin: Offset(-1, 0),
            end: Offset(0, 0),
          ).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          )),
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

  Widget _buildOption(IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        // Acción al presionar
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
}
