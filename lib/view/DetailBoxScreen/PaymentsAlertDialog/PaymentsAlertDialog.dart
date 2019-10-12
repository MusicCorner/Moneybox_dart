import 'package:flutter/material.dart';

class PaymenstAlertDialog extends StatelessWidget {
  final Function onChanged;
  final Function onCancel;
  final Function onSubmit;
  final String title;

  PaymenstAlertDialog({ this.onChanged, this.onCancel, this.onSubmit, this.title });

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: '100'
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: onCancel,
        ),
        FlatButton(
          child: Text('Ok'),
          onPressed: onSubmit,
        ),
      ],
    );
  }
}