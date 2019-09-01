import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/view/AddNewBoxPage/AddNewBoxPage.dart';
import 'package:flutter/material.dart';

class AddNewBoxStateful extends StatefulWidget {
  final BoxesModel boxesModel;

  AddNewBoxStateful({ Key key, this.boxesModel }) : super(key: key);

  @override
  AddNewBoxPage createState() => AddNewBoxPage(boxesModel: boxesModel);
}
