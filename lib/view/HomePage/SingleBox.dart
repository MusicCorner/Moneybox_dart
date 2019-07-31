import 'package:flutter/material.dart';

class SingleBox extends StatelessWidget {
  SingleBox({ this.box });
  final box;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[Text(box.name)],)
      ],
    );
  }
}