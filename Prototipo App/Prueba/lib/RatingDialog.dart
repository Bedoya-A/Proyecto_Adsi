import 'package:flutter/material.dart';

class RatingDialog extends StatefulWidget {
  final double initialRating;

  RatingDialog({required this.initialRating});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Califica tu experiencia'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: rating,
            min: 1.0,
            max: 5.0,
            divisions: 4,
            onChanged: (newRating) {
              setState(() {
                rating = newRating;
              });
            },
          ),
          Text(
            'Rating: ${rating.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, rating);
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
