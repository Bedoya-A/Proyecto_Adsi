import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Futurista de Seguimiento de Tiempo'),
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título de la página
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 2),
              child: Text(
                'Monitorea tu Tiempo',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Descripción de la aplicación
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

            // Estadísticas de tiempo
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 4),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.7),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Tiempo Total Transcurrido:',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '0:00:00', // Aquí se actualizará el tiempo real
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Botón para ir a la página de TimePage
            AnimatedContainer(
              duration: Duration(seconds: 1),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.7),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Text(
                'Ir a la Página de Tiempo',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // Botón flotante
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/time');
              },
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.watch_later),
            ),
          ],
        ),
      ),
    );
  }
}

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
        title: Text('Página de Tiempo'),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Título de la página
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

              // Descripción de la página
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

              // Reloj con animación
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.5), width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Text(
                    currentTime,
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Temporizador con borde y sombra
              Text(
                'Cuenta Regresiva:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 10),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.7),
                      blurRadius: 30,
                      spreadRadius: 5,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Text(
                  countdown,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Progreso visual del tiempo restante
              LinearProgressIndicator(
                value: secondsRemaining / 600,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),
              SizedBox(height: 20),

              // Botón para guardar el tiempo
              ElevatedButton(
                onPressed: _saveTime,
                child: Text('Guardar Tiempo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
