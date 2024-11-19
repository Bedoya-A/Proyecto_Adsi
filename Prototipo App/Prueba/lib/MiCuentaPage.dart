import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MiCuentaPage extends StatefulWidget {
  @override
  _MiCuentaPageState createState() => _MiCuentaPageState();
}

class _MiCuentaPageState extends State<MiCuentaPage> {
  String nombre = "Daniela Ospina";
  String correo = "danielaospina.1129@gmail.com";
  File? _fotoPerfil;
  final ImagePicker _picker = ImagePicker();

  // Variables para el tema
  ThemeMode _themeMode = ThemeMode.system;
  int _temaSeleccionado = 0; // 0: Sistema, 1: Claro, 2: Oscuro

  // Variables para accesibilidad
  bool _atajosModificador = false;
  bool _contrasteAlto = false;
  bool _subtitulos = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mi Cuenta'),
          backgroundColor: Colors.red,
        ),
        body: Container(
          decoration: _temaSeleccionado == 1
              ? BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade100,
                      Colors.white,
                    ],
                  ),
                )
              : null,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () => _cambiarFotoPerfil(),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _fotoPerfil != null
                          ? FileImage(_fotoPerfil!)
                          : AssetImage('assets/logo.png') as ImageProvider,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () => _cambiarFotoPerfil(),
                    child: Text(
                      'Cambiar la foto',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                Divider(),
                _buildEditableField(
                  'Nombre',
                  nombre,
                  Icons.person,
                  (nuevoValor) {
                    setState(() {
                      nombre = nuevoValor;
                    });
                  },
                ),
                Divider(),
                _buildEditableField(
                  'Correo electrónico',
                  correo,
                  Icons.email,
                  (nuevoValor) {
                    setState(() {
                      correo = nuevoValor;
                    });
                  },
                ),
                Divider(),
                _buildTemaSection(),
                Divider(),
                _buildAccesibilidadSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(
      String titulo, String valor, IconData icono, Function(String) onSave) {
    return ListTile(
      leading: Icon(icono, color: Colors.red),
      title: Text(titulo),
      subtitle: Text(valor),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          _mostrarDialogoEditar(context, titulo, valor, onSave);
        },
      ),
    );
  }

  Widget _buildTemaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tema',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTemaOption('Sincronizar con el sistema', 0),
            _buildTemaOption('Claro', 1),
            _buildTemaOption('Oscuro', 2),
          ],
        ),
      ],
    );
  }

  Widget _buildTemaOption(String titulo, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _temaSeleccionado = index;
          _themeMode = _getThemeMode(index);
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: _temaSeleccionado == index ? Colors.blue : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(
              index == 0
                  ? Icons.phone_android
                  : (index == 1 ? Icons.light_mode : Icons.dark_mode),
              color: _temaSeleccionado == index ? Colors.blue : Colors.grey,
            ),
            SizedBox(height: 5),
            Text(
              titulo,
              style: TextStyle(
                color: _temaSeleccionado == index ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ThemeMode _getThemeMode(int index) {
    switch (index) {
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Widget _buildAccesibilidadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accesibilidad',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildAccesibilidadOption(
          'Atajos necesitan modificador',
          Icons.keyboard,
          _atajosModificador,
          (value) {
            setState(() {
              _atajosModificador = value;
            });
          },
        ),
        _buildAccesibilidadOption(
          'Contraste alto de colores',
          Icons.contrast,
          _contrasteAlto,
          (value) {
            setState(() {
              _contrasteAlto = value;
            });
          },
        ),
        _buildAccesibilidadOption(
          'Subtítulos',
          Icons.subtitles,
          _subtitulos,
          (value) {
            setState(() {
              _subtitulos = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAccesibilidadOption(
      String titulo, IconData icono, bool estado, Function(bool) onChanged) {
    return SwitchListTile(
      title: Row(
        children: [
          Icon(icono, color: Colors.red),
          SizedBox(width: 10),
          Text(titulo),
        ],
      ),
      value: estado,
      onChanged: onChanged,
    );
  }

  void _mostrarDialogoEditar(BuildContext context, String titulo,
      String valorInicial, Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: valorInicial);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar $titulo'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Ingrese $titulo'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _cambiarFotoPerfil() async {
    final XFile? imagenSeleccionada =
        await _picker.pickImage(source: ImageSource.gallery);

    if (imagenSeleccionada != null) {
      setState(() {
        _fotoPerfil = File(imagenSeleccionada.path);
      });
    }
  }
}
