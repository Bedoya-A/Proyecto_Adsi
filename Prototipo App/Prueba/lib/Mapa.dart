import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Mapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapaScreen(),
    );
  }
}

class MapaScreen extends StatelessWidget {
  // Método para abrir Google Maps
  void _abrirGoogleMaps() async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/place/Mirador+Tesorito/@6.270894,-75.580238,15z');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abrir Mapa'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _abrirGoogleMaps,
          child: Text('Mapa'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
