import 'package:flutter/material.dart';
import 'package:prueba2/HomePage.dart';
import 'Menu.dart'; // Importa el menú que creaste

class JardinBotanico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors
                  .click, // Cambia el cursor al pasar sobre el logo
              child: GestureDetector(
                onTap: () {
                  // Navegar a la página de inicio
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Image.asset(
                  'assets/logo.png', // Ruta de tu logo
                  height: 40, // Altura del logo
                ),
              ),
            ),
            SizedBox(width: 10), // Espaciado entre el logo y el título
            Flexible(
              child: Text(
                'Jardín Botánico',
                overflow:
                    TextOverflow.ellipsis, // Agregar comportamiento de recorte
                maxLines: 1, // Limitar a una línea
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false, // Elimina la flecha de regresar
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context)
                    .openEndDrawer(); // Abre el menú lateral a la derecha
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'JARDÍN BOTÁNICO - BIODIVERSIDAD NATURAL',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Descubre la diversidad de flora y fauna que habita en nuestro Jardín Botánico. Un espacio para el aprendizaje y la conexión con la naturaleza.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildSectionTitle('Ubicación'),
            _buildInfoText('Vereda La Florida, Ibagué'),
            SizedBox(height: 20),
            _buildSectionTitle('Desde cuando se inauguró'),
            _buildInfoText('Este hermoso jardín se inauguró en marzo de 2023.'),
            SizedBox(height: 20),
            _buildSectionTitle('Servicios'),
            _buildInfoText('• Visitas guiadas de lunes a viernes\n'
                '• Talleres de jardinería y conservación\n'
                '• Espacios para eventos especiales'),
            SizedBox(height: 20),
            _buildSectionTitle('Objetivo del Jardín Botánico'),
            _buildInfoText(
                'Promover el conocimiento sobre la biodiversidad local y la importancia de la conservación de los ecosistemas.'),
          ],
        ),
      ),
      endDrawer: Menu(
        selectedDrawerIndex:
            7, // Cambia el índice seleccionado según corresponda
        onSelectDrawerItem: (index) {
          // Lógica para manejar la selección de elementos del menú
          // Puedes navegar a diferentes páginas según el índice seleccionado
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green[800],
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, height: 1.5),
    );
  }
}
