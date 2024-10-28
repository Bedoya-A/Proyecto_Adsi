import 'package:flutter/material.dart';

class OfferItem extends StatefulWidget {
  final String offer;
  final IconData icon;

  OfferItem({required this.offer, required this.icon});

  @override
  _OfferItemState createState() => _OfferItemState();
}

class _OfferItemState extends State<OfferItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300), // Duración de la animación
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.9).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _onTapDown() {
    _controller.forward(); // Inicia la animación al presionar
  }

  void _onTapUp() {
    _controller.reverse(); // Reversa la animación al soltar
  }

  void _onTapCancel() {
    _controller.reverse(); // Reversa la animación si el toque es cancelado
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          color: Colors.black.withOpacity(0.7),
          child: InkWell(
            onTapDown: (_) => _onTapDown(),
            onTapUp: (_) => _onTapUp(),
            onTapCancel: () => _onTapCancel(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(widget.icon, color: Colors.green, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.offer,
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
      ),
    );
  }
}
