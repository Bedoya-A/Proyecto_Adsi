import 'package:flutter/material.dart';

class OfferItem extends StatelessWidget {
  final String offer;
  final IconData icon;

  OfferItem({required this.offer, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        color: Colors.black.withOpacity(0.7),
        child: InkWell(
          onTap: () {
            // Acción al presionar, sin SnackBar
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.green, size: 30),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    offer,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
