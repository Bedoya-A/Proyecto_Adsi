import 'dart:async';
import 'package:flutter/material.dart';

class TimePage extends StatefulWidget {
  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  late String currentTime;
  late String countdown;
  late Timer timer;
  int secondsRemaining = 600; // 10 minutos en segundos
  int totalTimeSpent = 0; // Tiempo total transcurrido
  List<String> timeHistory = [];

  @override
  void initState() {
    super.initState();
    currentTime = _getCurrentTime();
    countdown = _formatTime(secondsRemaining);

    // Actualiza el reloj en tiempo real cada segundo
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        currentTime = _getCurrentTime();
      });

      // Actualiza la cuenta regresiva
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
          totalTimeSpent++; // Aumentar el tiempo total transcurrido
          countdown = _formatTime(secondsRemaining);
        });
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void _saveTime() {
    setState(() {
      timeHistory.add(currentTime);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiempo en la app'),
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título de la página con animación
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Text(
                  'Seguimiento de Tiempo',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Descripción de la página con animación
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 3),
                child: Text(
                  'Nuestra app registra el tiempo exacto que llevas conectado, ayudándote a gestionar mejor tu tiempo en cada sesión.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),

              // Reloj con animación, cajón más pequeño
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Reducido
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(15), // Borde más redondeado
                    border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 2), // Borde más fino
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        blurRadius: 10, // Menos difuso
                        offset: Offset(0, 4), // Menos desplazamiento
                      ),
                    ],
                  ),
                  child: Text(
                    currentTime,
                    style: TextStyle(
                      fontSize: 50, // Reducido el tamaño de la fuente
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Cuenta Regresiva: $countdown',
                style: TextStyle(
                    fontSize: 25, color: Colors.white), // Reducido el tamaño
              ),
              SizedBox(height: 20),
              LinearProgressIndicator(
                value: secondsRemaining / 600,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
