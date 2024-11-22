import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prueba2/Autoctonos.dart';
import 'package:prueba2/CabanaDelArbol.dart';
import 'package:prueba2/CabanaEncanto.dart';
import 'package:prueba2/CabanaLaMontana.dart';

import 'package:prueba2/CabanaParaiso.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/JardinBotanico.dart';
import 'package:prueba2/Meraki.dart';
import 'package:prueba2/MiradorTesorito.dart';
import 'package:prueba2/ParaisoEscondido.dart';
import 'package:prueba2/Transporte.dart';

class Menu extends StatefulWidget {
  final int selectedDrawerIndex;
  final Function(int) onSelectDrawerItem;

  Menu({required this.selectedDrawerIndex, required this.onSelectDrawerItem});

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  bool _isExpandedCorredores = false;
  bool _isExpandedCalambeo = false;
  bool _isExpandedAmbala = false;

  late AnimationController _rotationController;
  bool _isSelectedCorredores = false;
  bool _isHomeIconVisible = false;
  int _selectedSectionIndex = -1;

  void selectSection(int index) {
    setState(() {
      _selectedSectionIndex = index;

      // Cambia la expansión de acuerdo al índice
      if (index >= 5 && index <= 7) {
        _isExpandedCorredores = true;
        _isExpandedCalambeo = true;
        _isExpandedAmbala = false;
      } else if (index >= 1 && index <= 4) {
        _isExpandedCorredores = true;
        _isExpandedCalambeo = false;
        _isExpandedAmbala = true;
      } else {
        _isExpandedCorredores = false;
        _isExpandedCalambeo = false;
        _isExpandedAmbala = false;
      }
    });
  }

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
      _isHomeIconVisible = !_isHomeIconVisible;
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
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      _onLogoTap();
                      Future.delayed(Duration(milliseconds: 450), () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (Route<dynamic> route) => false,
                        );
                      });
                    },
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
                              size: 80,
                              color: Colors.white,
                            )
                          : CircleAvatar(
                              key: ValueKey('logoIcon'),
                              radius: 40,
                              backgroundImage: AssetImage('assets/logo.png'),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explora Calambeo - Ambalá',
                  style: TextStyle(color: Colors.white, fontSize: 20),
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
                                buildAnimatedDrawerItem('Paraíso Escondido', 1,
                                    Icons.home, context, ParaisoEscondido()),
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
