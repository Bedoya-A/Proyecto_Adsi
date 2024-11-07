import 'package:flutter/material.dart';
import 'package:prueba2/FormularioReserva.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/PaginaOferta.dart';
import 'package:prueba2/ServiciosJardinBotanico.dart';
import 'package:prueba2/ZoomImagen.dart';
import 'package:prueba2/menu.dart';
import 'package:url_launcher/url_launcher.dart';

class JardinBotanico extends StatefulWidget {
  @override
  State<JardinBotanico> createState() => _JardinBotanicoState();
}

class _JardinBotanicoState extends State<JardinBotanico>
    with TickerProviderStateMixin {
  bool _isHomeIconVisible = false;
  late TabController _tabController;

  int selectedDrawerIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible = !_isHomeIconVisible;
    });
  }

  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaginaOferta()),
      );
    }
  }

  void _openReservationForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reserva tu experiencia'),
          content: ReservationForm(
            onSubmit: (name, phone, dateStart, numPeople) {
              // Aquí puedes manejar el envío de la reserva o mostrar un mensaje de confirmación
              print(
                  "Reserva enviada:\nNombre: $name\nTeléfono: $phone\nFecha de Inicio: $dateStart\nNúmero de Personas: $numPeople");
              Navigator.of(context)
                  .pop(); // Cierra el diálogo después de enviar
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo sin enviar
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Jardín Botánico'),
            Tab(text: 'Servicios'),
          ],
        ),
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
        selectedDrawerIndex: selectedDrawerIndex,
        onSelectDrawerItem: onSelectDrawerItem,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildJardinBotanicoContent(),
          ServiciosJardinBotanico(),
        ],
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              _onLogoTap();
              Future.delayed(Duration(milliseconds: 350), () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
              });
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 350),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: _isHomeIconVisible
                  ? Icon(Icons.home,
                      key: ValueKey('homeIcon'), size: 40, color: Colors.white)
                  : CircleAvatar(
                      key: ValueKey('jardinLogo'),
                      radius: 20,
                      backgroundImage: AssetImage('assets/logo.png')),
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
    );
  }

  Widget _buildJardinBotanicoContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 10),
            _buildDescription(),
            SizedBox(height: 20),
            _buildSectionTitle("60 Hectáreas Llenas de Magia"),
            SizedBox(height: 10),
            _buildMagicDescription(),
            SizedBox(height: 20),
            _buildExplorationZones(),
            SizedBox(height: 30),
            _buildVideoLink(),
            SizedBox(height: 30),
            _buildSectionTitle("Reserva tu experiencia"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _openReservationForm,
              child: Text('Reserva'),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        'JARDÍN BOTÁNICO SAN JORGE',
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green[900]),
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      'El Jardín Botánico San Jorge se localiza en los cerros noroccidentales de Ibagué en el Departamento del Tolima. '
      'Se encuentra ubicado en la antigua Granja San Jorge, vía Calambeo, a cinco minutos del centro de la ciudad.',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildMagicDescription() {
    return Text(
      'Para el contacto vivencial con la naturaleza, el Jardín Botánico San Jorge cuenta con una extensión de 60 hectáreas, '
      'distribuidas en tres espacios, surcados por senderos ecológicos, organizados en circuitos, sobre los que se desarrollan diversos temas de estudio:',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildExplorationZones() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildImageCard('assets/insitu.jpeg', 'In Situ',
            'Alberga un bosque natural sub andino de la reserva forestal San Jorge.'),
        SizedBox(height: 10),
        _buildImageCard('assets/exsitu.jpeg', 'Ex Situ',
            'Donde habitan las colecciones de plantas vivas.'),
        SizedBox(height: 10),
        _buildImageCard('assets/arboretum.jpeg', 'Arboretum',
            'Donde se pueden encontrar los árboles más representativos del departamento.'),
      ],
    );
  }

  Widget _buildVideoLink() {
    return GestureDetector(
      onTap: () {
        launchUrl(
            Uri.parse('https://youtu.be/7CdXUBEqdIU?si=iMD1IlOyxAKS9QDF'));
      },
      child: Text(
        'Ver video del Jardin Botanico San Jorge en Youtube',
        style: TextStyle(
            fontSize: 16,
            color: Colors.blue,
            decoration: TextDecoration.underline),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[900]),
    );
  }

  Widget _buildImageCard(String imagePath, String title, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ImageZoomScreen(imagePath: imagePath)),
        );
      },
      child: Card(
        child: Column(
          children: [
            Image.asset(imagePath),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
