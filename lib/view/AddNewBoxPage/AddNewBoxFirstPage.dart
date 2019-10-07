import 'package:clicker/controllers/AddNewBoxFirstPageStateController.dart';
import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/scratches/SingleBoxScratch.dart';
import 'package:clicker/view/AddNewBoxPage/AddNewBoxBodyForm.dart';
import 'package:clicker/view/AddNewBoxPage/Common/NamedInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBoxFirstPage extends AddNewBoxFirstPageStateController {
  final BoxesModel boxesModel;
  SingleBoxScratch currentBox;

  AddNewBoxFirstPage({ Key key, this.boxesModel });

  // @override
  Widget build(BuildContext context) {
    List<Widget> namedInputsList = [
      NamedInput(onChanged: super.changeNameOfABox, title: 'Box name', hintText: 'Car'),
      NamedInput(onChanged: super.changeSumToCache, title: 'Sum to cache', hintText: '10 000'),
      NamedInput(onChanged: super.changeAlreadyCachedSum, title: 'Cached already', hintText: '1000'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add new box'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: AddNewBoxBodyForm(namedInputsList: namedInputsList,),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.navigate_next, color: Colors.white,),
        ),
        onPressed: () => super.goToNextPage(context),
      )
      
    );
  }
}
