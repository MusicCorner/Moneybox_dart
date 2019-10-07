import 'package:clicker/controllers/AddNewBoxSecondPageStateController.dart';
import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/scratches/SingleBoxScratch.dart';
import 'package:clicker/view/AddNewBoxPage/AddNewBoxBodyForm.dart';
import 'package:clicker/view/AddNewBoxPage/Common/NamedDateInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewBoxSecondPage extends AddNewBoxSecondPageStateController {
  final BoxesModel boxesModel;
  SingleBoxScratch currentBox;

  AddNewBoxSecondPage({ Key key, this.boxesModel, this.currentBox });

  Widget build(BuildContext context) {
    List<Widget> namedInputsList = [
      NamedDateInput(hintText: '10.10.2019', title: 'Start date', onTap: () => super.changeStartDate(context)),
      NamedDateInput(hintText: '10.10.2019', title: 'End date', onTap: () => super.changeEndDate(context))
    ];

    return Scaffold(
      body: AddNewBoxBodyForm(namedInputsList: namedInputsList,),
    );
  }
}