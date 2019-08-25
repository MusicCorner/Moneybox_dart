import 'package:clicker/constants/colors.dart';
import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/states/HomePageStateful.dart';
import 'package:clicker/view/Common/MyDecorationWrapper/MyDecorationWrapper.dart';
import 'package:clicker/view/HomePage/SingleBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends State<HomePageStateful> {
  HomePage({this.title = 'Default Title'});
  final String title;
  bool inputIsActive = false;
  String searchQuery = '';

  void _goToAddBoxScreen(context) {
    Navigator.pushNamed(context, '/addNewBox');
  }

  final TextEditingController  _searchController = TextEditingController();

  void _toggleSearchInput() {
    setState(() {
      inputIsActive = !inputIsActive;
    });
  }

  void _onChangeSearchInput(query) {
    setState(() {
      searchQuery = query;
    });
  }

  Widget getBoxes(context, boxesModel, child) {
    bool checkBoxIsShowed = !!boxesModel.boxes.any((item) => !!item.isSelected);
    List filteredBoxes = this.getSearchedResults(searchQuery, boxesModel.boxes);

    List<Widget> boxesWidgets = filteredBoxes.map<Widget>((box) => (
      SingleBox(box: box, toggleBoxSelection: boxesModel.toggleBoxSelection, checkBoxIsShowed: checkBoxIsShowed)
    )).toList();

    return MyDecorationWrapper(
      child: Container(
        child: Column(
          children: boxesWidgets
        ),
      )
    );
  }

  bool isNotMainCheckBoxSelected(boxes) {
    return boxes.any((item) => !!(item.isSelected && item.id != 0));
  }

  List getSearchedResults(String query, boxes) {
    if (query.isNotEmpty) {
      return boxes.where((box) => !!box.name.contains(query)).toList();
    }

    return boxes;
  }

  Widget getDeleteButton(context, boxesModel, child) {
    bool isNotMainCheckBoxSelected = this.isNotMainCheckBoxSelected(boxesModel.boxes);
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
    bool isNotMainCheckBoxSelected = this.isNotMainCheckBoxSelected(boxesModel.boxes);
    if (isNotMainCheckBoxSelected) {
      return IconButton(
        icon: Icon(Icons.close),
        onPressed: () => boxesModel.toggleAllBoxesSelection(false),
      );
    }

    return Text('');
  }

  Widget getSearchButton(context, boxesModel, child) {
    bool isAnyBoxSelected = boxesModel.boxes.any((item) => !!item.isSelected);
    if (isAnyBoxSelected) {
      return Text('');
    }

    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () => this._toggleSearchInput(),
    );
  }

  Widget getToggleAllCheckBoxes(context, boxesModel, child) {
    List listOfAvailableBoxes = boxesModel.boxes.where((item) => item.id != 0).toList();
    bool areAllCheckBoxesSelected = listOfAvailableBoxes.every((item) => !!item.isSelected);
    bool isAnyBoxSelected = boxesModel.boxes.any((item) => !!item.isSelected);
    bool areThereAnyBoxes = listOfAvailableBoxes.length > 0;

    if (areAllCheckBoxesSelected && areThereAnyBoxes) {
      return IconButton(
        icon: Icon(Icons.check_box),
        onPressed: () => boxesModel.toggleAllBoxesSelection(false),
      );
    }

    if (isAnyBoxSelected) {
      return IconButton(
        icon: Icon(Icons.check_box_outline_blank),
        onPressed: () => boxesModel.toggleAllBoxesSelection(true),
      );
    }

    return Text('');
  }

  List<Widget> getActionButtos() {
    Widget deleteButton = Consumer<BoxesModel>(builder: getDeleteButton);
    Widget closeButton = Consumer<BoxesModel>(builder: getCloseButton);
    Widget searchButton = Consumer<BoxesModel>(builder: getSearchButton);
    Widget toggleAllCheckBoxes = Consumer<BoxesModel>(builder: getToggleAllCheckBoxes);
    List<Widget> widgets = [deleteButton, closeButton, toggleAllCheckBoxes, searchButton];

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: inputIsActive ? TextField(
        controller: _searchController,
        onChanged: _onChangeSearchInput,
        cursorColor: WHITE_COLOR,
        style: TextStyle(color: WHITE_COLOR),
        autofocus: true,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.search),
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.grey)
          )
        ) : Text(title),
        actions: getActionButtos(),
      ),
      body: Center(
        child: Consumer<BoxesModel>(builder: getBoxes),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToAddBoxScreen(context),
        tooltip: 'Add new box',
        child: Icon(Icons.add, color: Colors.white, size: 28,),
        heroTag: 'btn1',
      ),
    );
  }
}
