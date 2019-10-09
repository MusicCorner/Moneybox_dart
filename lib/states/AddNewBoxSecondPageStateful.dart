import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/scratches/SingleBox.dart';
import 'package:clicker/view/AddNewBoxPage/AddNewBoxSecondPage.dart';
import 'package:flutter/material.dart';

class AddNewBoxSecondPageStateful extends StatefulWidget {
  final BoxesModel boxesModel;
  final SingleBox currentBox;

  AddNewBoxSecondPageStateful({ Key key, this.boxesModel, this.currentBox }) : super(key: key);

  @override
  AddNewBoxSecondPage createState() => AddNewBoxSecondPage(boxesModel: boxesModel, currentBox: currentBox);
}