import 'package:flutter/material.dart';
import 'package:prueba2/CustomTextField.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/LoginBackground.dart';
import 'package:prueba2/LoginButton.dart';
import 'package:prueba2/LoginErrorMessage.dart';
import 'package:prueba2/ModeloEstado.dart';
import 'package:prueba2/RegistroSesion.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/SocialLogos.dart';

class LoginPage extends StatefulWidget {
  final bool fromRegister;

  LoginPage({this.fromRegister = false});

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
      Provider.of<AppState>(context, listen: false).setLoginStatus(true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sesión iniciada correctamente'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

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
      body: BackgroundWrapper(
        imageAsset: 'assets/img1.jpg',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
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
              CustomButton(
                onPressed: _login,
                text: 'Iniciar sesión',
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
              ),
              SizedBox(height: 20),
              // Aquí van los logotipos de Google y otras opciones
              SocialLogos(),
              SizedBox(height: 20),
              if (_errorMessage != null) ErrorMessage(message: _errorMessage!),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterPage(fromLogin: true)),
                  );
                },
                child: Text(
                  '¿No tienes una cuenta? Regístrate aquí',
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
