import 'package:flutter/material.dart';
import 'package:prueba2/HomePage.dart';
import 'Menu.dart'; // Importa el menú que creaste

class MiradorTesorito extends StatefulWidget {
  @override
  _MiradorTesoritoState createState() => _MiradorTesoritoState();
}

class _MiradorTesoritoState extends State<MiradorTesorito> {
  bool _isHomeIconVisible = false; // Control for logo visibility

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible = !_isHomeIconVisible; // Toggle the visibility
    });

    // Espera a que la animación termine antes de navegar
    Future.delayed(Duration(milliseconds: 350), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap:
                    _onLogoTap, // Cambia la visibilidad del ícono al hacer clic
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 350),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: _isHomeIconVisible
                      ? Icon(
                          Icons.home,
                          key: ValueKey('homeIcon'),
                          size: 40, // Tamaño del ícono de inicio
                          color: Colors.white,
                        )
                      : CircleAvatar(
                          key: ValueKey('logoIcon'),
                          radius: 20, // Radio del logo
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                ),
              ),
            ),
            SizedBox(width: 10), // Espaciado entre el logo y el título
            Flexible(
              // Usar Flexible para evitar el desbordamiento
              child: Text(
                'Mirador Tesorito',
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
              'MIRADOR TESORITO - COMIDA TÍPICA RURAL',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Sumérgete en la tranquilidad del campo mientras disfrutas de una vista impresionante de la ciudad. Saborea delicias caseras con ingredientes frescos, y vive una experiencia que une lo mejor del campo y la ciudad en un solo lugar.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildSectionTitle('Ubicación'),
            _buildInfoText('Vereda Alcon Tesorito, Ibagué'),
            SizedBox(height: 20),
            _buildSectionTitle('Desde cuando inició este mirador'),
            _buildInfoText(
                'Este increíble y maravilloso mirador comenzó a operar en mayo de 2024.'),
            SizedBox(height: 20),
            _buildSectionTitle('Servicios'),
            _buildInfoText(
                '• Restaurante sábados, domingos y festivos de 11:00 AM a 10:00 PM\n'
                '• Reservas con dos días de anticipación\n'
                '• Celebraciones especiales\n'
                '• Servicio a domicilio fines de semana'),
            SizedBox(height: 20),
            _buildSectionTitle('Rescatar los sabores del campo'),
            _buildInfoText(
                'Donde reviven la esencia de la tierra con sabores auténticos y frescos. Utilizan ingredientes autóctonos y técnicas tradicionales para ofrecer platos únicos que combinan tradición y modernidad.'),
            SizedBox(height: 20),
            _buildSectionTitle('Capacidad del Mirador'),
            _buildInfoText(
                'El mirador tiene una capacidad de 50 a 60 personas, ideal para eventos íntimos y celebraciones especiales.'),
          ],
        ),
      ),
      endDrawer: Menu(
        selectedDrawerIndex:
            6, // Cambia el índice seleccionado según corresponda
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
