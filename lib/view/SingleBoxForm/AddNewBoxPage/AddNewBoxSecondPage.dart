import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/models/SingleBox.dart';
import 'package:clicker/controllers/states/AddNewBoxSecondPageStateful.dart';
import 'package:clicker/view/SingleBoxForm/AddNewBoxPage/BoxFormBodyComponent.dart';
import 'package:clicker/view/SingleBoxForm/Common/NamedDateInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewBoxSecondPage extends State<AddNewBoxSecondPageStateful> {
  final BoxesModel boxesModel;
  SingleBox currentBox;

  AddNewBoxSecondPage({ Key key, this.boxesModel, this.currentBox });

  final startDateInputController = TextEditingController();
  final endDateInputController = TextEditingController();

  String _getDateString(DateTime dateTime) {
    String day = dateTime.day <= 9 ? '0${dateTime.day}' : dateTime.day.toString();

    return '${dateTime.year}.${dateTime.month}.$day';
  }

  Future<Null> _changeStartDate(context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: currentBox.startDate != null ? currentBox.startDate : DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: currentBox.endDate != null ? currentBox.endDate : DateTime(2101)
    );

    if (pickedDate != null) {
      String startDateString = _getDateString(pickedDate);

      setState(() {
        currentBox.startDate = pickedDate;
        startDateInputController.text = startDateString;
      });
      return;
    }

    return;
  }

  Future<Null> _changeEndDate(context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: currentBox.endDate != null ? currentBox.endDate : DateTime.now(),
      firstDate: currentBox.startDate,
      lastDate: DateTime(2101)
    );

    if (pickedDate != null) {
      String endDateString = _getDateString(pickedDate);

      setState(() {
        currentBox.endDate = pickedDate;
        endDateInputController.text = endDateString;
      });
    }
  }

  void _submit(BuildContext context) {
    boxesModel.addNewBox(currentBox);
    Navigator.popUntil(context, (Route route) => route.isFirst);
  }

  Widget _getFloatingActionButton(BuildContext context) {
    if (startDateInputController.text != '' && endDateInputController.text != '') {
      return FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.check, color: Colors.white,),
        ),
        onPressed: () => _submit(context)
      );
    }

    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> namedInputsList = [
      NamedDateInput(
        hintText: '2019.10.10',
        title: 'Start date',
        onTap: () => _changeStartDate(context),
        controller: startDateInputController
      ),
      NamedDateInput(
        hintText: '2019.10.10',
        title: 'End date',
        onTap: () => _changeEndDate(context),
        controller: endDateInputController,
        enabled: startDateInputController.text != ''
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add new box'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BoxFormBodyComponent(namedInputsList: namedInputsList,),
      floatingActionButton: _getFloatingActionButton(context),
    );
  }
}