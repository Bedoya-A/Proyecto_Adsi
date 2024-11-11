import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'Menu.dart';
import 'HomePage.dart';

class Transporte extends StatefulWidget {
  @override
  _TransporteState createState() => _TransporteState();
}

class _TransporteState extends State<Transporte> {
  int _selectedDrawerIndex = 9;
  bool _isHomeIconVisible = false;

  void _onSelectDrawerItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
    Navigator.pop(context);
  }

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible = !_isHomeIconVisible;
    });
    Future.delayed(Duration(milliseconds: 350), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    });
  }

  // Método para abrir Google Maps usando URL
  Future<void> _launchGoogleMaps() async {
    const url = 'https://www.google.com/maps'; // URL de Google Maps
    try {
      // Intentamos abrir el URL en un navegador
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      // Utiliza el navegador para abrir la URL de Google Maps
      await launchURL(url);
    } catch (e) {
      print("No se pudo abrir Google Maps");
    }
  }

  // Función para abrir la URL en el navegador
  Future<void> launchURL(String url) async {
    final methodChannel = MethodChannel('com.flutter/webview');
    try {
      await methodChannel.invokeMethod('launchURL', url);
    } catch (e) {
      print("Error: $e");
    }
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
                onTap: _onLogoTap,
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
                          size: 40,
                          color: Colors.white,
                        )
                      : CircleAvatar(
                          key: ValueKey('logoIcon'),
                          radius: 20,
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                'Servicios de Transporte',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue[700],
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Menu(
        selectedDrawerIndex: _selectedDrawerIndex,
        onSelectDrawerItem: _onSelectDrawerItem,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medios de Transporte en Ibagué',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Explora las diferentes opciones de transporte que ofrece la ciudad de Ibagué:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildTransportSection(
              'Taxis',
              'assets/taxi.jpg',
              '• Disponibilidad 24 horas.\n• Tarifa mínima: \$5,500.\n• Solicitud por calle o apps como Easy Taxi y Tappsi.\n• Seguridad: Verificar placa y conductor identificado.',
              context,
            ),
            _buildTransportSection(
              'Busetas',
              'assets/buseta.jpg',
              '• Principal medio de transporte público.\n• Tarifa: \$2,800.\n• Amplia cobertura en la ciudad.\n• Circulación frecuente de día, menor frecuencia de noche.',
              context,
            ),
            _buildTransportSection(
              'Uber',
              'assets/uber.jpg',
              '• Servicio disponible vía app.\n• Tarifas variables según demanda.\n• Pago en efectivo o tarjeta.\n• Disponibilidad limitada en zonas periféricas.',
              context,
            ),
            _buildTransportSection(
              'DiDi',
              'assets/didi.jpeg',
              '• Alternativa a Uber.\n• Tarifas más económicas, promociones frecuentes.\n• Pago en efectivo o tarjeta.\n• Seguridad: Comparte tu viaje en tiempo real.',
              context,
            ),
            SizedBox(height: 20),
            Text(
              '¡Viaja seguro y elige el transporte que mejor se ajuste a tus necesidades!',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _launchGoogleMaps,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(
                  'Abrir Google Maps',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransportSection(String title, String imagePath,
      String description, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: GestureDetector(
        onTap: () => _showImage(context, imagePath),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        description,
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        child: Stack(
          children: [
            PhotoView(
              imageProvider: AssetImage(imagePath),
              backgroundDecoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.red, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
