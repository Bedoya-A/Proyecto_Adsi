import 'package:flutter/material.dart';

class ServicioDetalle extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  ServicioDetalle(
      {required this.title, required this.image, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InteractiveViewer(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
