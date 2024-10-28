import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/ModeloEstado.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(), // Proporciona el estado
      child: MaterialApp(
        title: 'AppExplora Calambeo - Ambalá',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false, // Eliminar la banda de depuración
      ),
    );
  }
}
