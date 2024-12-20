import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class ReservationForm extends StatefulWidget {
  final Function(String, String, String, String, int)
      onSubmit; // Modificado para incluir la fecha de finalización

  ReservationForm({required this.onSubmit});

  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final MaskedTextController _dateController =
      MaskedTextController(mask: '00/00/0000'); // Mascara para DD/MM/AAAA
  final MaskedTextController _endDateController = MaskedTextController(
      mask: '00/00/0000'); // Mascara para la fecha de finalización
  final TextEditingController _numPeopleController = TextEditingController();

  bool _isSubmitting = false; // Variable para saber si está enviando
  bool _isSuccessful = false; // Variable para saber si la reserva fue exitosa

  void _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        if (isStartDate) {
          _dateController.text =
              "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
        } else {
          _endDateController.text =
              "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
        }
      });
    }
  }

  void _handleSubmit() async {
    if (_nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _endDateController.text.isNotEmpty &&
        _numPeopleController.text.isNotEmpty) {
      // Convertir las fechas a DateTime para validación
      DateTime start =
          DateTime.parse(_dateController.text.split('/').reversed.join('-'));
      DateTime end =
          DateTime.parse(_endDateController.text.split('/').reversed.join('-'));

      DateTime currentDate = DateTime.now();

      // Validación de la fecha de inicio
      if (start.isBefore(currentDate)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('La fecha de inicio no puede ser menor a la fecha actual.'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      // Validación de la fecha de finalización
      if (end.isBefore(start)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'La fecha de finalización debe ser igual o posterior a la fecha de inicio.'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      setState(() {
        _isSubmitting = true; // Activar la carga
      });

      // Simulación de un retraso de procesamiento (puedes cambiarlo a tu lógica real)
      await Future.delayed(Duration(seconds: 2));

      // Simulamos que el envío es exitoso
      widget.onSubmit(
        _nameController.text,
        _phoneController.text,
        _dateController.text,
        _endDateController.text, // Se envía la fecha de finalización
        int.tryParse(_numPeopleController.text) ?? 0,
      );

      setState(() {
        _isSubmitting = false; // Desactivar la carga
        _isSuccessful = true; // Marcar como exitoso
      });

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('¡Reserva realizada con éxito!'),
        backgroundColor: Colors.green,
      ));

      // Limpiar campos después del éxito
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _nameController.clear();
          _phoneController.clear();
          _dateController.clear();
          _endDateController.clear(); // Limpiar la fecha de finalización
          _numPeopleController.clear();
          _isSuccessful = false; // Resetear estado
        });

        // Cerrar el formulario automáticamente
        Navigator.pop(context); // Cerrar el formulario
      });
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario de Reserva"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Reserva',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 20),
            // Nombre completo
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre completo'),
            ),
            // Teléfono
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Teléfono'),
            ),
            // Fecha de la reserva
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Fecha de la reserva (DD/MM/AAAA)',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, true),
                ),
              ),
              keyboardType: TextInputType.datetime,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d|/'))
              ],
            ),
            // Fecha de finalización
            TextFormField(
              controller: _endDateController,
              decoration: InputDecoration(
                labelText: 'Fecha de finalización (DD/MM/AAAA)',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, false),
                ),
              ),
              keyboardType: TextInputType.datetime,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d|/'))
              ],
            ),
            // Número de personas
            TextFormField(
              controller: _numPeopleController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número de personas'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSubmitting || _isSuccessful
                  ? null
                  : _handleSubmit, // Desactivar si está enviando o fue exitoso
              child: _isSubmitting
                  ? CircularProgressIndicator(color: Colors.white)
                  : _isSuccessful
                      ? Icon(Icons.check_circle, color: Colors.white)
                      : Text('Enviar Reserva'),
            ),
          ],
        ),
      ),
    );
  }
}
