import 'package:flutter/material.dart';

class PaymenstAlertDialog extends StatelessWidget {
  final Function onChanged;
  final Function onCancel;
  final Function onSubmit;

  PaymenstAlertDialog({ this.onChanged, this.onCancel, this.onSubmit });

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add payments'),
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