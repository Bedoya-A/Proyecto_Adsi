import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/InicioSesion.dart';
import 'package:prueba2/ModeloEstado.dart';
import 'package:prueba2/MyLozalizations.dart';
import 'package:prueba2/RegistroSesion.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          // Detectar el brillo del sistema
          Brightness systemBrightness =
              MediaQuery.of(context).platformBrightness;
          // Actualiza el tema si es necesario
          appState.updateThemeMode(systemBrightness);
          return MaterialApp(
            title: 'AppExplora Calambeo - Ambalá',
            themeMode: appState.themeMode, // Usar el themeMode desde AppState
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: HomePage(), // Página inicial
            debugShowCheckedModeBanner: false,

            // Configuración de localización
            locale: appState.locale, // Usar la propiedad locale de AppState
            supportedLocales: [
              Locale('es', ''), // Español
              Locale('en', ''), // Inglés
              Locale('fr', ''), // Francés
            ],
            localizationsDelegates: [
              ...GlobalMaterialLocalizations
                  .delegates, // Usa el plural de delegates
              GlobalWidgetsLocalizations.delegate,
              MyLocalizationsDelegate(), // Solo un delegado para todos los idiomas
            ],

            // Rutas
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
