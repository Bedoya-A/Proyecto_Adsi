import 'package:flutter/material.dart';

class GradientAnimation extends StatefulWidget {
  @override
  _GradientAnimationState createState() => _GradientAnimationState();
}

class _GradientAnimationState extends State<GradientAnimation> {
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isMenuOpen =
            true; // Activa la animación después de la construcción inicial
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isMenuOpen
              ? [
                  Color(0xFF4CAF50), // Verde vibrante
                  Color(0xFF03A9F4), // Azul cielo
                ]
              : [
                  Color(0xFF81C784), // Verde inicial
                  Color(0xFFB3E5FC), // Azul inicial
                ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
