import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class ContactSupportPage extends StatefulWidget {
  @override
  _ContactSupportPageState createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage>
    with TickerProviderStateMixin {
  bool _isDarkMode = false;
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedLanguage = 'Español';
  String _emailError = '';
  bool _isChecked = false; // Checkbox para "No soy robot"
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animación para el título al cargar
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactar con soporte técnico'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner superior con animación
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: _animation.value,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    '¿Cómo podemos ayudarle?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Selector de idioma con animación
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _isDarkMode
                          ? [BoxShadow(color: Colors.purple, blurRadius: 15)]
                          : [BoxShadow(color: Colors.blue, blurRadius: 15)],
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Idioma',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedLanguage,
                      items: ['Español', 'Inglés', 'Francés']
                          .map((lang) => DropdownMenuItem(
                                value: lang,
                                child: Text(lang),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Selección del motivo
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Seleccione un motivo',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                          value: 'Problema técnico',
                          child: Text('Problema técnico')),
                      DropdownMenuItem(
                          value: 'Consulta general',
                          child: Text('Consulta general')),
                      DropdownMenuItem(
                          value: 'Reclamación', child: Text('Reclamación')),
                    ],
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 20),
                  // Campo para el correo electrónico con borde animado
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Tu correo electrónico',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                      errorText: _emailError.isEmpty ? null : _emailError,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _emailError = _isValidEmail(value)
                            ? ''
                            : 'Por favor, ingrese un correo válido';
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // Campo para escribir el mensaje con borde animado
                  TextField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Escríbenos un mensaje',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.message_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Texto de protección de datos
                  Text(
                    'Información básica sobre Protección de Datos: Freepik Company tratará tus datos para dar respuesta a tus consultas, sugerencias o reclamaciones remitidas, en base al consentimiento prestado al pulsar el botón “Enviar”. Tus datos no serán cedidos a terceros y se transferirán fuera de la UE en los términos de la política de privacidad.',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // Acción al presionar "política de privacidad"
                    },
                    child: Text(
                      'política de privacidad.',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Checkbox "No soy robot"
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                      Text(
                        'No soy robot',
                        style: TextStyle(
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Botón de enviar con efectos de hover
                  Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.blueAccent],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_emailError.isEmpty && _isChecked) {
                            // Mostrar el mensaje de éxito
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('¡Mensaje enviado con éxito!'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // Reiniciar la información del formulario
                            _emailController.clear();
                            _messageController.clear();
                            setState(() {
                              _isChecked = false;
                              _emailError = ''; // Limpiar el error del email
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Por favor, complete todos los campos.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        icon: Icon(Icons.email_outlined, color: Colors.white),
                        label: Text(
                          'Enviar',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }
}
