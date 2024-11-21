import 'package:flutter/material.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/ModeloEstado.dart';
import 'package:prueba2/RegistroSesion.dart';
import 'package:provider/provider.dart'; // Para interactuar con AppState

class LoginPage extends StatefulWidget {
  final bool fromRegister; // Verifica si el usuario viene del registro

  LoginPage({this.fromRegister = false}); // Constructor con el parámetro

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  void _login() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage =
            'Por favor, ingrese su correo electrónico y contraseña.';
      });
      return;
    }

    if (email == 'adsi@gmail.com' && password == '12345') {
      // Actualizamos el estado global
      Provider.of<AppState>(context, listen: false).setLoginStatus(true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sesión iniciada correctamente'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Navegamos a HomePage reemplazando el LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        _errorMessage = 'Credenciales incorrectas. Intente nuevamente.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión'),
        backgroundColor: Colors.red,
        leading: widget.fromRegister
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterPage(fromLogin: true)),
                  );
                },
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
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
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar sesión'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterPage(fromLogin: true)),
                );
              },
              child: Text('¿No tienes una cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
