import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/Autoctonos.dart';
import 'package:prueba2/CambioTemaButton.dart';
import 'package:prueba2/CustomDrawerHeader.dart';
import 'package:prueba2/JardinBotanico.dart';
import 'package:prueba2/LanguajeSwitchButton.dart';
import 'package:prueba2/Meraki.dart';
import 'package:prueba2/MiradorTesorito.dart';
import 'package:prueba2/ModeloEstado.dart';
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomDrawerHeader(),
          ExpansionTile(
            leading: buildAnimatedCorredoresIcon(
                _isExpandedCorredores), // Aplicamos ambas animaciones
            title: Text('Corredores Turísticos'),
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpandedCorredores = expanded;
              });
              // Controlamos la animación de rotación cuando se expande o colapsa
              _isExpandedCorredores
                  ? _rotationController.forward()
                  : _rotationController.reverse();
            },
            children: _isExpandedCorredores
                ? [
                    ExpansionTile(
                      leading: buildAnimatedIcon(
                          Color(0xFFD6F6DD), _isExpandedAmbala),
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
                    ExpansionTile(
                      leading: buildAnimatedIcon(
                          Color(0xFFD6F6DD), _isExpandedCalambeo),
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
                  ]
                : [],
          ),
          buildAnimatedDrawerItem('Servicio de Transporte', 9,
              Icons.directions_bus, context, Transporte()),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<AppState>(
                  builder: (context, appState, child) {
                    return LightDarkSwitch(
                      value: appState.themeMode == ThemeMode.dark,
                      onChanged: (bool newValue) {
                        appState.setThemeMode(
                            newValue ? ThemeMode.dark : ThemeMode.light);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAnimatedDrawerItem(
      String title, int index, IconData icon, BuildContext context,
      [Widget? page]) {
    bool isSelected = widget.selectedDrawerIndex == index;

    return Material(
      elevation: isSelected ? 8 : 0,
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected
              ? Color(0xff828a95) // Mismo color que el DrawerHeader
              : Colors.grey, // Color por defecto
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? Colors.black // Color del texto cuando está seleccionado
                : null, // Color por defecto del texto
          ),
        ),
        selected: isSelected,
        tileColor:
            isSelected ? Color(0xFFD6F6DD) : null, // Fondo al seleccionar
        selectedTileColor: Color(0xFFD6F6DD),
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
      title: Text(
        title,
      ),
      children: children
          .animate(interval: 150.ms)
          .slideY(begin: 1, end: 0, duration: 400.ms)
          .fadeIn(duration: 500.ms, curve: Curves.easeInOutQuad),
    );
  }

  Widget buildAnimatedIcon(Color color, bool isExpanded) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        begin: Colors.grey.withOpacity(0.7),
        end: isExpanded
            ? Color.fromARGB(255, 149, 255, 172)
            : Colors.grey.withOpacity(0.7),
      ),
      duration: Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Icon(
          Icons.nature_people,
          color: value, // Color animado
        );
      },
    );
  }

  Widget buildAnimatedCorredoresIcon(bool isExpanded) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        begin: Colors.grey.withOpacity(0.7), // Color cuando está colapsado
        end: isExpanded
            ? Color.fromARGB(255, 149, 255, 172)
            : Colors.grey, // Color cuando está expandido
      ),
      duration: Duration(milliseconds: 300), // Duración para el cambio suave
      builder: (context, value, child) {
        return AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationController.value * 2 * 3.14159,
              child: Icon(
                Icons.explore, // Icono anterior
                color: value, // Color animado
              ).animate().fadeIn(duration: 300.ms).scale(
                    duration: 300.ms,
                    curve: Curves.easeInOut,
                  ),
            );
          },
        );
      },
    );
  }
}
