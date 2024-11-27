import 'package:flutter/material.dart';

class SocialLogos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo de Google (puedes usar una imagen local o un icono)
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/googlelogo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 20),
        // Logo de Facebook (si tienes)
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/facebooklogo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
