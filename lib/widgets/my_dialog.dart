import 'package:flutter/material.dart';

class MyDialog {
  final BuildContext context;
  final String item;
  final VoidCallback? onConfirm;
  const MyDialog({
    required this.context,
    required this.item,
    this.onConfirm,
  });

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ATENÇÃO'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Você esta excluindo $item '),
                const Text('Deseja realmente confirmar?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onConfirm,
              child: const Text('Confirmar'),
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
