import 'package:clicker/models/BoxesModel.dart';
// import 'package:clicker/states/SingleBoxState.dart';
import 'package:clicker/view/HomePage/SingleBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({this.title = 'Default Title'});
  final String title;

  void _goToAddBoxScreen(context) {
    Navigator.pushNamed(context, '/addNewBox');
  }

  Widget getBoxes(context, boxesModel, child) {
    bool checkBoxIsShowed = !!boxesModel.boxes.any((item) => !!item.isSelected);
    List<Widget> boxesWidgets = boxesModel.boxes.map<Widget>((box) => (
      SingleBox(box: box, toggleBoxSelection: boxesModel.toggleBoxSelection, checkBoxIsShowed: checkBoxIsShowed,)
    )).toList();

    return Column(
      children: boxesWidgets
    );
  }

  bool isNotMainCheckBoxSelected(boxes) {
    return boxes.any((item) => !!(item.isSelected && item.id != 0));
  }

  Widget getDeleteButton(context, boxesModel, child) {
    bool isNotMainCheckBoxSelected = boxesModel.boxes.any((item) => !!(item.isSelected && item.id != 0));
    List boxesIdToDelete = boxesModel.boxes.where((box) => !!box.isSelected).map((item) => item.id).toList();
    if (isNotMainCheckBoxSelected) {
      return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => boxesModel.deleteBoxes(boxesIdToDelete),
      );
    }

    return Text('');
  }

  Widget getCloseButton(context, boxesModel, child) {
    bool isNotMainCheckBoxSelected = boxesModel.boxes.any((item) => !!item.isSelected);
    if (isNotMainCheckBoxSelected) {
      return IconButton(
        icon: Icon(Icons.close),
        onPressed: () => boxesModel.toggleAllBoxesSelection(false),
      );
    }

    return Text('');
  }

  List<Widget> getActionButtos() {
    Widget deleteButton = Consumer<BoxesModel>(builder: getDeleteButton);
    
    Widget closeButton = Consumer<BoxesModel>(builder: getCloseButton);
    List<Widget> widgets = [deleteButton, closeButton];
   return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: getActionButtos(),
      ),
      body: Center(
        child: Consumer<BoxesModel>(builder: getBoxes)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToAddBoxScreen(context),
        tooltip: 'Add new box',
        child: Icon(Icons.add),
        heroTag: 'btn1',
      ),
    );
  }
}
