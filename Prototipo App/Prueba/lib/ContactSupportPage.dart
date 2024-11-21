import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Para animaciones dinámicas
import 'package:url_launcher/url_launcher.dart';
import 'FAQPage.dart'; // Asegúrate de tener una página FAQPage.dart

class ContactSupportPage extends StatefulWidget {
  @override
  _ContactSupportPageState createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedLanguage = 'Español';
  bool _isRobotChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _opacity = 0.0;
  bool _isVisible = false;

  // Función para validar el correo
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo';
    }
    final regex =
        RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
    if (!regex.hasMatch(value)) {
      return 'Por favor ingresa un correo válido';
    }
    return null;
  }

  // Función para validar el mensaje
  String? _validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa un mensaje';
    }
    return null;
  }

  // Función para enviar el formulario
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_isRobotChecked) {
        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Se ha enviado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Mostrar un mensaje de error si no se marca la casilla "No soy un robot"
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor, marca la casilla "No soy un robot"'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Función para mostrar el diálogo de soporte
  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Centro de Soporte',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Cómo podemos ayudarte?',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.purple),
                  title: const Text('Correo Electrónico'),
                  subtitle: const Text('soporte@tuempresa.com'),
                  onTap: _launchEmail,
                ),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.purple),
                  title: const Text('Teléfono'),
                  subtitle: const Text('+1 800 123 456'),
                  onTap: _launchPhone,
                ),
                ListTile(
                  leading: const Icon(Icons.help, color: Colors.purple),
                  title: const Text('FAQ'),
                  subtitle: const Text('Preguntas frecuentes'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cerrar',
                style: TextStyle(color: Colors.purple.shade900),
              ),
            ),
          ],
        );
      },
    );
  }

  // Función para lanzar el correo
  void _launchEmail() async {
    final url = 'mailto:soporte@tuempresa.com?subject=Soporte';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir el correo';
    }
  }

  // Función para realizar una llamada telefónica
  void _launchPhone() async {
    final url = 'tel:+1800123456';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede realizar la llamada';
    }
  }

  // Función para mostrar el menú del BottomSheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.purple.shade900,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.white),
              title:
                  const Text('Soporte', style: TextStyle(color: Colors.white)),
              onTap: () => _showSupportDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Animación de entrada de la página
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0; // Activamos la animación de opacidad
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Contacto Soporte',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showBottomSheet(context),
          ),
        ],
      ),
      body: AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: _opacity,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade900, Colors.blue.shade500],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      child: Center(
                        child: Text(
                          '¡Estamos aquí para ayudarte!',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 200.ms),
                    const SizedBox(height: 20),
                    _buildDropdown(),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: 'Correo Electrónico',
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 20),
                    _buildMessageField(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Información básica sobre Protección de Datos: Freepik Company tratará tus datos para dar respuesta a tus consultas, sugerencias o reclamaciones remitidas, en base al consentimiento prestado al pulsar el botón "Enviar". Tus datos no serán cedidos a terceros y se transferirán fuera de la UE en los términos de la política de privacidad.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    _buildRobotCheck(),
                    const SizedBox(height: 30),
                    // Botón Enviar centrado
                    Center(
                      child: _buildSendButton(),
                    ),
                    const SizedBox(height: 30),
                    _buildSocialMediaButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedLanguage,
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value!;
        });
      },
      items: ['Español', 'Inglés', 'Francés']
          .map((lang) => DropdownMenuItem<String>(
                value: lang,
                child: Text(lang, style: TextStyle(color: Colors.black)),
              ))
          .toList(),
      decoration: InputDecoration(
        labelText: 'Idioma',
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon: Icon(icon, color: Colors.blue.shade700),
      ),
    );
  }

  Widget _buildMessageField() {
    return TextFormField(
      controller: _messageController,
      validator: _validateMessage,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Mensaje',
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildRobotCheck() {
    return Row(
      children: [
        Checkbox(
          value: _isRobotChecked,
          onChanged: (value) {
            setState(() {
              _isRobotChecked = value!;
            });
          },
          activeColor: Colors.blue.shade700,
        ),
        const Text(
          'No soy un robot',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSendButton() {
    return ElevatedButton(
      onPressed: _isRobotChecked
          ? () {
              _submitForm();
            }
          : null,
      child: const Text('Enviar', style: TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange.shade700, // Hacemos el botón más visible
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildSocialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.facebook, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.phone_android, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.phishing, color: Colors.white),
        ),
      ],
    );
  }
}
