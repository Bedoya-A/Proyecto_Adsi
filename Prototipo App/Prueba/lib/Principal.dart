import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/InicioSesion.dart';
import 'package:prueba2/ModeloEstado.dart';
import 'package:prueba2/RegistroSesion.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: Consumer<AppState>(
        // Aquí usas Consumer para obtener el estado del tema
        builder: (context, appState, child) {
          return MaterialApp(
            title: 'AppExplora Calambeo - Ambalá',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: appState.themeMode, // Usar el themeMode desde AppState
            home: HomePage(), // Aquí inicializa con HomePage
            debugShowCheckedModeBanner: false,
            // Configuración de rutas
            routes: {
              '/home': (context) => HomePage(),
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterPage(),
            },
          );
        },
      ),
    );
  }
}
