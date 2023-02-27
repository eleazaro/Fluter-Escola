import 'package:flutter/material.dart';
import 'package:flutter_escola/shared/fixed_string.dart';

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(FixedString.attention),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(FixedString.deleting + item),
                Text(FixedString.reallyConfirm),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onConfirm,
              child: Text(FixedString.confirm),
            ),
            TextButton(
              child: Text(FixedString.cancel),
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
