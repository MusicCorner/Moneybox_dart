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
  final TextEditingController  _searchController = TextEditingController();
  FocusNode _searchInputFocusNode = FocusNode();

  void _goToAddBoxScreen(context) {
    Navigator.pushNamed(context, '/addNewBox');
  }

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
      return boxes.where((box) => !!box.name.toLowerCase().contains(query.toLowerCase())).toList();
    }

    return boxes;
  }

  void submitDeletion(context, boxesModel, boxesIdsToDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text("You are going to delete ${boxesIdsToDelete.length} boxes!"),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                boxesModel.toggleAllBoxesSelection(false);
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                boxesModel.deleteBoxes(boxesIdsToDelete);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Widget getDeleteButton(context, boxesModel, child) {
    bool isNotMainCheckBoxSelected = this.isNotMainCheckBoxSelected(boxesModel.boxes);
    List boxesIdsToDelete = boxesModel.boxes.where((box) => !!box.isSelected).map((item) => item.id).toList();
    if (isNotMainCheckBoxSelected) {
      return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => submitDeletion(context, boxesModel, boxesIdsToDelete),
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

    if (inputIsActive && searchQuery.length > 0) {
      return IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          setState(() {
            searchQuery = '';
          });
          _searchController.text = '';

          // this._toggleSearchInput();
        },
      );
    }

    if (!inputIsActive) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: this._toggleSearchInput,
      );
    }

    return Text('');
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

  Widget getLeadingButton() {
    if (inputIsActive) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            searchQuery = '';
          });
          _searchController.text = '';

          this._toggleSearchInput();
        },
      );
    }

    return null;
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
          focusNode: _searchInputFocusNode,
          decoration: InputDecoration(
            // prefixIcon: Icon(Icons.search),
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey)
          )
        ) : Text(title),
        actions: getActionButtos(),
        leading: getLeadingButton(),
      ),
      body: 
      GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Consumer<BoxesModel>(builder: getBoxes),
        )
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
