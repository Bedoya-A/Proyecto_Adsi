import 'package:flutter/material.dart';
import 'package:prueba2/CustomTextField.dart';
import 'package:prueba2/InicioSesion.dart'; // Asegúrate de importar la página de Login
import 'package:prueba2/LoginBackground.dart';
import 'package:prueba2/LoginButton.dart';
import 'package:prueba2/LoginErrorMessage.dart';
import 'SocialLogos.dart'; // Importa el widget de SocialLogos

class RegisterPage extends StatefulWidget {
  final bool fromLogin; // Determina si viene desde Login o no

  RegisterPage({this.fromLogin = false}); // Constructor

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _errorMessage;

  void _register() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, complete todos los campos.';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Las contraseñas no coinciden.';
      });
      return;
    }

    if (_isValidEmail(email)) {
      // Simula que el registro fue exitoso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cuenta creada exitosamente'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Si el registro es exitoso, redirige al LoginPage
      if (widget.fromLogin) {
        Navigator.pop(
            context); // Cierra la página de registro y vuelve al login
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } else {
      setState(() {
        _errorMessage = 'Por favor, ingrese un correo electrónico válido.';
      });
    }
  }

  bool _isValidEmail(String email) {
    RegExp emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear cuenta'),
        leading: widget.fromLogin
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Volver al login
                },
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Cerrar la página
                },
              ),
      ),
      body: BackgroundWrapper(
        imageAsset: 'assets/registroImagen.jpg',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_add,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomTextField(
                  controller: _emailController,
                  labelText: 'Correo electrónico',
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomTextField(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  isPassword: true,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomTextField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirmar contraseña',
                  isPassword: true,
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                onPressed: _register,
                text: 'Crear cuenta',
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
              ),
              SizedBox(height: 20),
              // Agregamos el widget de logotipos
              SocialLogos(),

              if (_errorMessage != null) ErrorMessage(message: _errorMessage!),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  '¿Ya tienes una cuenta? Inicia sesión aquí',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
