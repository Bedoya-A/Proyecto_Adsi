// editable_field.dart
import 'package:flutter/material.dart';

class EditableField extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;
  final Function(String) onSave;

  EditableField({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icono, color: Colors.red),
      title: Text(titulo),
      subtitle: Text(valor),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          _mostrarDialogoEditar(context, titulo, valor, onSave);
        },
      ),
    );
  }

  void _mostrarDialogoEditar(BuildContext context, String titulo,
      String valorInicial, Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: valorInicial);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar $titulo'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Ingrese $titulo'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
