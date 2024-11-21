import 'package:flutter/material.dart';
import 'package:prueba2/InicioSesion.dart'; // Asegúrate de importar la página de Login

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
      // Si el registro es exitoso, redirigir al LoginPage
      if (widget.fromLogin) {
        // Si viene desde el LoginPage, simplemente vuelve a la página de inicio de sesión
        Navigator.pop(
            context); // Cierra la página de registro y vuelve al login
      } else {
        // Si no, redirige al LoginPage con un push
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
        backgroundColor: Colors.red,
        leading: widget.fromLogin
            ? IconButton(
                icon: Icon(
                    Icons.arrow_back), // Flecha de retroceso si viene del login
                onPressed: () {
                  Navigator.pop(context); // Volver al login
                },
              )
            : IconButton(
                icon: Icon(Icons
                    .close), // Mostrar ícono de cerrar si no viene del login
                onPressed: () {
                  Navigator.pop(context); // Cerrar la página
                },
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'Ingresa tu correo electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                hintText: 'Ingresa tu contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
                hintText: 'Vuelve a ingresar tu contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Crear cuenta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text('¿Ya tienes una cuenta? Inicia sesión aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
