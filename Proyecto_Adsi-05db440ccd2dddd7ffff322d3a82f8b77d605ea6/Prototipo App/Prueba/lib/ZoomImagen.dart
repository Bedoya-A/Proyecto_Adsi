import 'package:flutter/material.dart';

class ImageZoomScreen extends StatelessWidget {
  final String imagePath;

  ImageZoomScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
