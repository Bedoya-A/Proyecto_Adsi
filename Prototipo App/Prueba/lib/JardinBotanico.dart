import 'package:flutter/material.dart';
import 'package:prueba2/HomePage.dart';
import 'Menu.dart'; // Importa el menú que creaste

class JardinBotanico extends StatefulWidget {
  @override
  _JardinBotanicoState createState() => _JardinBotanicoState();
}

class _JardinBotanicoState extends State<JardinBotanico> {
  bool _isHomeIconVisible = false; // Control para la visibilidad del logo

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible =
          !_isHomeIconVisible; // Cambia la visibilidad del ícono
    });

    // Espera a que termine la animación antes de navegar
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
                'Jardín Botánico',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false,
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
      endDrawer: Menu(
        selectedDrawerIndex: 1, // Índice de la página actual
        onSelectDrawerItem: (int index) {
          // Lógica para la navegación basada en el índice seleccionado
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.pop(
                context); // Si ya estamos en JardinBotanico, cierra el drawer
          }
        },
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildDescriptionSection(),
          SizedBox(height: 20),
          _buildTitle('Zonas de Exploración'),
          SizedBox(height: 10),
          _buildZonaCard('IN SITU',
              'Alberga un bosque natural subandino de la reserva forestal San Jorge.'),
          _buildZonaCard(
              'EX SITU', 'Donde habitan las colecciones de plantas vivas.'),
          _buildZonaCard('ARBORETUM',
              'Donde se pueden encontrar los árboles más representativos del departamento.'),
          SizedBox(height: 20),
          _buildLocationSection(),
          SizedBox(height: 20),
          _buildTitle('Servicios'),
          SizedBox(height: 10),
          _buildServiceCard('Observación de Aves',
              'Disfruta de guianzas diurnas o nocturnas para avistamiento y fotografía de aves.'),
          _buildServiceCard('Senderismo',
              'Con 7 km de senderos en tres circuitos con diferentes niveles de dificultad.'),
          SizedBox(height: 20),
          _buildAttentionHoursSection(),
          SizedBox(height: 20),
          _buildTitle('Guianzas Especializadas'),
          SizedBox(height: 10),
          _buildServiceCard('Cultivo y Uso de Plantas Medicinales',
              'Recorrido sobre el manejo y aprovechamiento de plantas aromáticas y medicinales.'),
          _buildServiceCard('Sistemática Vegetal',
              'Guianza diurna para público universitario interesado en botánica.'),
          SizedBox(height: 20),
          _buildTitle('Eventos Familiares y Corporativos'),
          SizedBox(height: 10),
          Text(
            'Actividades diseñadas para fomentar cooperación, ingenio y trabajo en equipo.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          _buildPetPolicySection(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return _buildInfoCard(
      title: 'Descripción',
      content:
          'El Jardín Botánico San Jorge, sobre los cerros noroccidentales de Ibagué, es un espacio de 60 ha donde los visitantes pueden recorrer senderos de bosque subandino. Se destacan las colecciones de orquídeas, bromelias, palmas y heliconias, así como plantas medicinales y aromáticas.',
    );
  }

  Widget _buildLocationSection() {
    return _buildInfoCard(
      title: 'Ubicación',
      content:
          'Vía Calambeo antigua granja San Jorge, Ibagué, Colombia.\nTel: 313 3783055\nCorreo electrónico: jardinsanjorge@gmail.com',
    );
  }

  Widget _buildAttentionHoursSection() {
    return _buildInfoCard(
      title: 'Horarios de Atención',
      content:
          'Lunes a Domingos y Festivos de 8:00 a.m. a 4:30 p.m.\nNo es necesario agendar, pueden venir directamente.',
    );
  }

  Widget _buildPetPolicySection() {
    return _buildInfoCard(
      title: 'Visita el Jardín Botánico con tu Mascota',
      content:
          '• Mantén siempre a tu mascota con collar y junto a ti.\n• Trae bolsitas para sus necesidades.\n• Asegúrate de traer hidratación para tu mascota.',
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Container(
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
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
