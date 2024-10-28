import 'package:flutter/material.dart';

class Meraki extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parque Temático Meraki',
            style:
                TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[800],
        elevation: 6,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.teal[50]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Ubicación', Icons.location_on),
              _buildText('Vereda Villa Vista, Avenida Ambalá'),
              _buildText('Inaugurado hace 14 años.'),
              SizedBox(height: 20),
              _buildHeader('Atracciones', Icons.attractions),
              _buildCard(
                'Bicicletas Aéreas',
                'Disfruta de una experiencia segura e inolvidable. Recorrido de 500 metros (ida y vuelta) por 50 mil pesos.',
                'Sábados, domingos y festivos de 9:00 AM - 5:00 PM',
              ),
              _buildCard(
                'Senderos',
                'Recorre nuestros senderos con vistas panorámicas de la ciudad y aprende sobre el cultivo de cacao y café.',
                '1 km: 10 mil pesos | 2.5 km: 15 mil pesos',
              ),
              _buildCard(
                'Capilla San Nicolás',
                'Un espacio de paz y elegancia para bodas, bautizos y otras ceremonias religiosas.',
              ),
              _buildCard(
                'Mirador',
                'Vistas excepcionales de la ciudad y paisajes cafeteros. Perfecto para fotos y descanso.',
              ),
              SizedBox(height: 20),
              _buildHeader('Pasadía Meraki', Icons.star),
              _buildText(
                  'Incluye parqueadero, recorrido por senderos, almuerzo, bici paseo aéreo, zona de hamacas y seguro.'),
              SizedBox(height: 20),
              _buildHeader('Restaurante', Icons.restaurant_menu),
              _buildText(
                  'Carta de Presentación - Comienza con una taza de café en Meraki'),
              _buildSubHeader('Entradas'),
              _buildPriceItem('Chorizo + arepa + limón', 12000),
              _buildPriceItem('Chicharrón + papa criolla + guacamole', 15000),
              _buildSubHeader('Pescados'),
              _buildPriceItem(
                  'Filete de pescado a la plancha + verduras + puré de papa criolla',
                  40000),
              _buildPriceItem('Mojarra frita + patacón + ensalada', 35000),
              _buildSubHeader('Carnes'),
              _buildPriceItem(
                  'Carne a la plancha + papa criolla + ensalada', 35000),
              _buildPriceItem('Costillas + papa criolla + ensalada', 38000),
              _buildSubHeader('Comidas Rápidas'),
              _buildPriceItem('Salchipapa', 20000),
              _buildPriceItem('Alitas BBQ + papas a la francesa', 20000),
              _buildSubHeader('Cafetería'),
              _buildPriceItem('Café', 2000),
              _buildPriceItem('Chocolate en leche', 5000),
              SizedBox(height: 20),
              _buildHeader('Contacto', Icons.phone),
              _buildText(
                  'Teléfonos: 3187156890 (Logística) | 3122751769 (Nelson)'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal[800], size: 28),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
            fontFamily: 'Raleway',
          ),
        ),
      ],
    );
  }

  Widget _buildSubHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.teal[600],
          fontFamily: 'Raleway',
        ),
      ),
    );
  }

  Widget _buildCard(String title, String description,
      [String additionalInfo = '']) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800]),
            ),
            SizedBox(height: 8),
            Text(description,
                style: TextStyle(fontSize: 16, color: Colors.grey[800])),
            if (additionalInfo.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                additionalInfo,
                style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16, color: Colors.grey[800], fontFamily: 'Raleway'),
      ),
    );
  }

  Widget _buildPriceItem(String item, int price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item, style: TextStyle(fontSize: 16, fontFamily: 'Raleway')),
          Text('\$$price',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway')),
        ],
      ),
    );
  }
}
