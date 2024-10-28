import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prueba2/Autoctonos.dart';
import 'package:prueba2/CabanaDelArbol.dart';
import 'package:prueba2/CabanaEncanto.dart';
import 'package:prueba2/CabanaLaMontana.dart';
import 'package:prueba2/CabanaParaiso.dart';
import 'package:prueba2/Contacto.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/JardinBotanico.dart';
import 'package:prueba2/Meraki.dart';
import 'package:prueba2/MiradorTesorito.dart';
import 'package:prueba2/Transporte.dart';

class Menu extends StatefulWidget {
  final int selectedDrawerIndex;
  final Function(int) onSelectDrawerItem;

  Menu({required this.selectedDrawerIndex, required this.onSelectDrawerItem});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  bool _isExpandedCorredores = false;
  bool _isExpandedCalambeo = false;
  bool _isExpandedAmbala = false;

  // Controlador de animación para la rotación del ícono
  late AnimationController _rotationController;
  bool _isSelectedCorredores = false; // Estado de selección
  bool _isHomeIconVisible = false; // Estado para mostrar el ícono de inicio

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _toggleCorredores() {
    setState(() {
      _isExpandedCorredores = !_isExpandedCorredores;
      _isExpandedCorredores
          ? _rotationController.forward()
          : _rotationController.reverse();
    });
  }

  void _selectCorredores() {
    setState(() {
      _isSelectedCorredores = true;
    });
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isSelectedCorredores = false;
      });
    });
  }

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible =
          true; // Muestra el ícono de inicio al hacer clic en el logo
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isHomeIconVisible =
            false; // Oculta el ícono de inicio después de 1 segundo
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false, // Elimina todas las rutas anteriores
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _onLogoTap,
                  child: _isHomeIconVisible
                      ? Icon(
                          Icons.home,
                          size: 80, // Tamaño del ícono de inicio
                          color: Colors.white,
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explora Calambeo',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
          ExpansionTile(
            leading: AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationController.value * 2 * 3.14159,
                  child: Transform.scale(
                    scale: _isSelectedCorredores ? 1.2 : 1.0,
                    child: Icon(Icons.explore).animate().fadeIn(
                          duration: 500.ms,
                          curve: Curves.easeInOut,
                        ),
                  ),
                );
              },
            ),
            title: Text('Corredores Turísticos'),
            onExpansionChanged: (expanded) {
              _toggleCorredores();
              _selectCorredores();
            },
            children: _isExpandedCorredores
                ? [
                    // Sección Calambeo
                    ExpansionTile(
                      leading: Icon(Icons.nature_people)
                          .animate()
                          .scale(
                            duration: 300.ms,
                            curve: Curves.easeInOutQuad,
                          )
                          .fadeIn(
                            duration: 500.ms,
                            curve: Curves.easeInOutQuad,
                          ),
                      title: Text('Calambeo'),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _isExpandedCalambeo = expanded;
                        });
                      },
                      children: _isExpandedCalambeo
                          ? [
                              buildAnimatedExpansionTile(
                                  'Miradores y restaurante', [
                                buildAnimatedDrawerItem(
                                    'Mirador Tesorito',
                                    5,
                                    Icons.visibility,
                                    context,
                                    MiradorTesorito()),
                                buildAnimatedDrawerItem('Mirador Autóctonos', 6,
                                    Icons.visibility, context, Autoctonos()),
                              ]),
                              buildAnimatedExpansionTile(
                                  'Aventura y Naturaleza', [
                                buildAnimatedDrawerItem('Jardín Botánico', 7,
                                    Icons.eco, context, JardinBotanico()),
                              ]),
                            ]
                          : [],
                    ),
                    // Sección Ambalá
                    ExpansionTile(
                      leading: Icon(Icons.nature_people)
                          .animate()
                          .scale(
                            duration: 300.ms,
                            curve: Curves.easeInOutQuad,
                          )
                          .fadeIn(
                            duration: 500.ms,
                            curve: Curves.easeInOutQuad,
                          ),
                      title: Text('Ambalá'),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _isExpandedAmbala = expanded;
                        });
                      },
                      children: _isExpandedAmbala
                          ? [
                              buildAnimatedExpansionTile('Cabañas', [
                                buildAnimatedDrawerItem(
                                    'Cabaña Paraíso Escondido',
                                    1,
                                    Icons.home,
                                    context,
                                    CabanaParaiso()),
                                buildAnimatedDrawerItem('Cabaña del Árbol', 2,
                                    Icons.home, context, CabanaDelArbol()),
                                buildAnimatedDrawerItem('Cabaña La Montaña', 3,
                                    Icons.home, context, CabanaLaMontana()),
                                buildAnimatedDrawerItem('Cabaña El Encanto', 4,
                                    Icons.home, context, CabanaEncanto()),
                              ]),
                              buildAnimatedExpansionTile('Parques', [
                                buildAnimatedDrawerItem(
                                    'Parque Temático Meraki',
                                    8,
                                    Icons.eco,
                                    context,
                                    Meraki()),
                              ]),
                            ]
                          : [],
                    ),
                  ]
                : [],
          ),
          buildAnimatedDrawerItem('Servicio de Transporte', 9,
              Icons.directions_bus, context, Transporte()),
          buildAnimatedDrawerItem(
              'Contacto', 10, Icons.contact_mail, context, Contacto()),
        ],
      ),
    );
  }

  Widget buildAnimatedDrawerItem(
      String title, int index, IconData icon, BuildContext context,
      [Widget? page]) {
    return Material(
      elevation: widget.selectedDrawerIndex == index ? 8 : 0,
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        leading: Icon(
          icon,
          color: widget.selectedDrawerIndex == index
              ? Colors.yellow
              : Colors.black,
        )
            .animate()
            .scale(
              duration: 400.ms,
              curve: Curves.easeInOutQuad,
            )
            .then()
            .fadeIn(
              duration: 500.ms,
              curve: Curves.easeInOutQuad,
            ),
        title: Text(
          title,
          style: TextStyle(
            color: widget.selectedDrawerIndex == index
                ? Colors.yellow
                : Colors.black,
          ),
        ),
        selected: widget.selectedDrawerIndex == index,
        tileColor:
            widget.selectedDrawerIndex == index ? Colors.redAccent : null,
        selectedTileColor: Colors.redAccent,
        onTap: () {
          widget.onSelectDrawerItem(index);
          if (page != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
      ),
    );
  }

  Widget buildAnimatedExpansionTile(String title, List<Widget> children) {
    return ExpansionTile(
      title: Text(title),
      children: children
          .animate(interval: 150.ms)
          .slideY(begin: 1, end: 0, duration: 400.ms)
          .fadeIn(duration: 500.ms, curve: Curves.easeInOutQuad),
    );
  }
}
