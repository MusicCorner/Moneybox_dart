import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/view/HomePage/SingleBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({this.title});
  final String title;

  void _goToAddBoxScreen(context) {
    Navigator.pushNamed(context, '/addNewBox');
  }

  Widget getBoxes(context, boxesModel, child) {
    // return Text('lol');
    List<Widget> boxesWidgets = boxesModel.boxes.map<Widget>((box) => (
      // Text('lol')
      SingleBox(box: box)
    )).toList();
    return Column(
      children: boxesWidgets
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Consumer<BoxesModel>(
          builder: getBoxes,
        )
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
