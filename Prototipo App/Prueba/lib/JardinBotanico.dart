import 'package:flutter/material.dart';
import 'package:prueba2/HomePage.dart';
import 'Menu.dart'; // Asegúrate de que el menú esté importado correctamente

class JardinBotanico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
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
            SizedBox(width: 10), // Espaciado entre el logo y el título
            Flexible(
              // Usar Flexible para evitar el desbordamiento
              child: Text(
                'Jardín Botánico San Jorge',
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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Descripción del Jardín Botánico
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descripción',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'El Jardín Botánico San Jorge, sobre los cerros noroccidentales de Ibagué, es un espacio de 60 ha en el que los visitantes pueden recorrer senderos de bosque subandino. Se destacan las colecciones de orquídeas, bromelias, palmas y heliconias, así como plantas medicinales y aromáticas.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Zonas de exploración
          Text(
            'Zonas de Exploración',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildZonaCard('IN SITU',
              'Alberga un bosque natural subandino de la reserva forestal San Jorge.'),
          _buildZonaCard(
              'EX SITU', 'Donde habitan las colecciones de plantas vivas.'),
          _buildZonaCard('ARBORETUM',
              'Donde se pueden encontrar los árboles más representativos del departamento.'),
          SizedBox(height: 20),

          // Ubicación
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ubicación',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Vía Calambeo antigua granja San Jorge, Ibagué, Colombia.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Tel: 313 3783055',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Correo electrónico: jardinsanjorge@gmail.com',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Servicios
          Text(
            'Servicios',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildServiceCard('Observación de Aves',
              'Disfruta de guianzas diurnas o nocturnas, ideales para los amantes del avistamiento y fotografía de aves.'),
          _buildServiceCard('Senderismo',
              'Con 7 km de senderos en tres circuitos, cada uno con diferentes niveles de dificultad.'),
          SizedBox(height: 20),

          // Horarios de atención
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Horarios de Atención',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Lunes a Domingos y Festivos de 8:00 a.m. a 4:30 p.m.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'No es necesario agendar, pueden venir directamente.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Guianzas especializadas
          Text(
            'Guianzas Especializadas',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildServiceCard('Cultivo y Uso de Plantas Medicinales',
              'Recorrido dirigido a quienes desean aprender sobre el manejo y aprovechamiento de plantas aromáticas y medicinales.'),
          _buildServiceCard('Sistemática Vegetal',
              'Guianza diurna para público universitario interesado en profundizar en botánica.'),
          SizedBox(height: 20),

          // Eventos familiares y corporativos
          Text(
            'Eventos Familiares y Corporativos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Actividades diseñadas para fomentar cooperación, ingenio y trabajo en equipo.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),

          // Información sobre mascotas
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visita el Jardín Botánico con tu Mascota',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  '• Mantén siempre a tu mascota con collar y junto a ti.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '• Trae bolsitas para sus necesidades.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '• Asegúrate de traer hidratación para tu mascota.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
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

  Widget _buildZonaCard(String title, String description) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildServiceCard(String title, String description) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
