import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class ReservationForm extends StatefulWidget {
  final Function(String, String, String, int) onSubmit;

  ReservationForm({required this.onSubmit});

  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final MaskedTextController _dateController =
      MaskedTextController(mask: '00/00/0000'); // Mascara para DD/MM/AAAA
  final TextEditingController _numPeopleController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _handleSubmit() {
    if (_nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _numPeopleController.text.isNotEmpty) {
      widget.onSubmit(
        _nameController.text,
        _phoneController.text,
        _dateController.text,
        int.tryParse(_numPeopleController.text) ?? 0,
      );
    } else {
      // Mostrar un mensaje de error si faltan campos
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor complete todos los campos'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre completo'),
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Teléfono'),
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Fecha de la reserva (DD/MM/AAAA)',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              keyboardType: TextInputType.datetime,
              inputFormatters: [
                // Si quieres permitir solo números y la barra
                FilteringTextInputFormatter.allow(RegExp(r'\d|/'))
              ],
            ),
            TextFormField(
              controller: _numPeopleController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número de personas'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Enviar Reserva'),
            ),
          ],
        ),
      ),
    );
  }
}
