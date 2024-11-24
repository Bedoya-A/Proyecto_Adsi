import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase
import 'package:prueba2/Principal.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura que Flutter se inicialice antes
  await Firebase.initializeApp(); // Inicializa Firebase
  runApp(const Principal()); // Ejecuta la clase Principal
}
