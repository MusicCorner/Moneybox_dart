import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/view/AddNewBoxPage/AddNewBoxFirstPage.dart';
import 'package:flutter/material.dart';

class AddNewBoxFirstPageStateful extends StatefulWidget {
  final BoxesModel boxesModel;

  AddNewBoxFirstPageStateful({ this.boxesModel });

  @override
  AddNewBoxFirstPage createState() => AddNewBoxFirstPage(boxesModel: boxesModel);
}
