import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/scratches/SingleBoxScratch.dart';
import 'package:clicker/states/AddNewBoxSecondPageStateful.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AddNewBoxSecondPageStateController extends State<AddNewBoxSecondPageStateful> {
  final BoxesModel boxesModel;
  SingleBoxScratch currentBox;

  AddNewBoxSecondPageStateController({ this.boxesModel, this.currentBox });

  Future<Null> changeStartDate(context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );

    if (pickedDate != null) {
      setState(() {
        currentBox.startDate = pickedDate;
      });
      return;
    }

    return;
  }

  Future<Null> changeEndDate(context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );

    if (pickedDate != null) {
      setState(() {
        currentBox.endDate = pickedDate;
      });
    }
  }
}