import 'package:clicker/AddNewBoxPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBoxState extends State<AddNewBoxPage> {
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
        child: Text('Hello!')
      )
    );
  }
}
