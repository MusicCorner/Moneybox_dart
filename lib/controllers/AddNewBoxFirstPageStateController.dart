import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/scratches/SingleBoxScratch.dart';
import 'package:clicker/states/AddNewBoxFirstPageStateful.dart';
import 'package:clicker/states/AddNewBoxSecondPageStateful.dart';
import 'package:flutter/material.dart';

abstract class AddNewBoxFirstPageStateController extends State<AddNewBoxFirstPageStateful> {
  final BoxesModel boxesModel;
  SingleBoxScratch currentBox;

  AddNewBoxFirstPageStateController({ this.boxesModel, this.currentBox });

  @override
  void initState() {
    currentBox = SingleBoxScratch(name: '', id: boxesModel.boxes.length);
    print(currentBox);
    super.initState();
  }

  void changeNameOfABox(String name) {
    setState(() {
      currentBox.name = name;
    });
  }

  void changeSumToCache(String sumToCache) {
    setState(() {
      currentBox.sumToCache = int.parse(sumToCache);
    });
  }

  void changeAlreadyCachedSum(String alreadyCached) {
    setState(() {
      currentBox.cachedAlready = int.parse(alreadyCached);
    });
  }

  void goToNextPage(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewBoxSecondPageStateful(boxesModel: boxesModel, currentBox: currentBox,)));
  }
}