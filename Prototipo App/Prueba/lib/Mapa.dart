import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late GoogleMapController _mapController;

  // Coordenadas del Mirador Tesorito (ajusta según tu necesidad)
  final LatLng _initialPosition =
      LatLng(5.0667, -75.5167); // Ejemplo: Manizales, Colombia
  final Marker _miradorMarker = Marker(
    markerId: MarkerId("mirador_tesorito"),
    position: LatLng(5.0667, -75.5167),
    infoWindow: InfoWindow(
      title: "Mirador Tesorito",
      snippet: "Un lugar increíble para disfrutar",
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa del Mirador Tesorito'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 15, // Nivel de zoom inicial
        ),
        markers: {_miradorMarker},
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToMirador,
        child: Icon(Icons.location_on),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Método para centrar el mapa en el Mirador Tesorito
  void _moveToMirador() {
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_initialPosition, 18), // Zoom más cercano
    );
  }
}
