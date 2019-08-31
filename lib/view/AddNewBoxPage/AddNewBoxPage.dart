import 'package:clicker/states/AddNewBoxState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBoxPage extends State<AddNewBoxState> {
  int _needToCacheSum = 0;

  void _editNeedToCacheSum(value) {
    setState(() {
      _needToCacheSum = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new box'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              
            )
          ],
        ),
      )
    );
  }
}
