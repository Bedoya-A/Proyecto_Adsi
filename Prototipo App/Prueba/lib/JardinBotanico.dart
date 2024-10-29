import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateStartController = TextEditingController();
  final _numPeopleController = TextEditingController();
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

  void _selectDate(TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
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
            _buildReservationForm(),
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

  Widget _buildReservationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
              "Nombre", _nameController, TextInputType.text, Icons.person),
          SizedBox(height: 10),
          _buildTextField("Número de Teléfono", _phoneController,
              TextInputType.phone, Icons.phone),
          SizedBox(height: 10),
          _buildTextField("Fecha de Inicio", _dateStartController,
              TextInputType.none, Icons.calendar_today,
              onTap: () => _selectDate(_dateStartController)),
          SizedBox(height: 10),
          _buildTextField("Número de Personas", _numPeopleController,
              TextInputType.number, Icons.group),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Aquí puedes agregar la lógica para enviar la reserva
              }
            },
            child: Text("Reservar"),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      TextInputType inputType, IconData icon,
      {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa tu $label';
          }
          return null;
        },
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
