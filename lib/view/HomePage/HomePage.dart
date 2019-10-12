import 'package:clicker/common/styles/MainTextStyle.dart';
import 'package:clicker/constants/colors.dart';
import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/states/AddNewBoxFirstPageStateful.dart';
import 'package:clicker/states/HomePageStateful.dart';
import 'package:clicker/view/Common/MyDecorationWrapper/MyDecorationWrapper.dart';
import 'package:clicker/view/HomePage/SingleBoxComponent.dart';
import 'package:flutter/material.dart';

class HomePage extends State<HomePageStateful> {
  BoxesModel boxesModel;

  HomePage({ this.boxesModel });

  final String title = 'Money Boxes';
  bool inputIsActive = false;
  String searchQuery = '';
  final TextEditingController  _searchController = TextEditingController();
  FocusNode _searchInputFocusNode = FocusNode();

  @override
  void initState() {
    boxesModel.initBoxesFromStorage();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _searchController.dispose();
    _searchInputFocusNode.dispose();
    super.dispose();
  }

  void _goToAddBoxScreen(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewBoxFirstPageStateful(boxesModel: boxesModel)));
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

  Widget getBoxes(context) {
    bool checkBoxIsShowed = !!boxesModel.boxes.any((item) => !!item.isSelected);
    List filteredBoxes = this.getSearchedResults(searchQuery, boxesModel.boxes);
    List<Widget> boxesWidgetList = filteredBoxes.map<Widget>((box) => (
      SingleBoxComponent(box: box, toggleBoxSelection: boxesModel.toggleBoxSelection, checkBoxIsShowed: checkBoxIsShowed)
    )).toList();

    Widget childToReturn = Column(
      children: boxesWidgetList
    );

    if (boxesWidgetList.length == 0) {
      childToReturn = Text('You have no money boxes', style: TextStyle(color: WHITE_COLOR, fontSize: 18));
    }

    return MyDecorationWrapper(
      child: Container(
        child: childToReturn,
      )
    );
  }

  bool isNotMainCheckBoxSelected(boxes) {
    return boxes.any((item) => !!(item.isSelected));
  }

  List getSearchedResults(String query, boxes) {
    if (query.isNotEmpty) {
      return boxes.where((box) => !!box.name.toLowerCase().contains(query.toLowerCase())).toList();
    }

    return boxes;
  }

  void submitDeletion(context, boxesIdsToDelete) {
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

  Widget getDeleteButton(context) {
    bool isNotMainCheckBoxSelected = this.isNotMainCheckBoxSelected(boxesModel.boxes);
    List boxesIdsToDelete = boxesModel.boxes.where((box) => !!box.isSelected).map((item) => item.id).toList();
    if (isNotMainCheckBoxSelected) {
      return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => submitDeletion(context, boxesIdsToDelete),
      );
    }

    return Text('');
  }

  Widget getCloseButton(context) {
    bool isNotMainCheckBoxSelected = this.isNotMainCheckBoxSelected(boxesModel.boxes);
    if (isNotMainCheckBoxSelected) {
      return IconButton(
        icon: Icon(Icons.close),
        onPressed: () => boxesModel.toggleAllBoxesSelection(false),
      );
    }

    return Text('');
  }

  Widget getSearchButton(context) {
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
          FocusScope.of(context).requestFocus(_searchInputFocusNode);
        },
      );
    }

    if (!inputIsActive) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          FocusScope.of(context).requestFocus(_searchInputFocusNode);
          this._toggleSearchInput();
        }
      );
    }

    return Text('');
  }

  Widget getToggleAllCheckBoxes(context) {
    bool areAllCheckBoxesSelected = boxesModel.boxes.every((item) => !!item.isSelected);
    bool isAnyBoxSelected = boxesModel.boxes.any((item) => !!item.isSelected);
    bool areThereAnyBoxes = boxesModel.boxes.length > 0;

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

  List<Widget> getActionButtos(context) {
    Widget deleteButton = getDeleteButton(context);
    Widget closeButton = getCloseButton(context);
    Widget searchButton = getSearchButton(context);
    Widget toggleAllCheckBoxes = getToggleAllCheckBoxes(context);

    List<Widget> widgets = [deleteButton, closeButton, toggleAllCheckBoxes, searchButton];

    return widgets;
  }

  Widget getLeadingButton(context) {
    if (inputIsActive) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            searchQuery = '';
          });
          _searchController.text = '';
          FocusScope.of(context).requestFocus(FocusNode());
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
        title: Row(
          children: <Widget>[
            Container(
              child: TextField(
                controller: _searchController,
                onChanged: _onChangeSearchInput,
                cursorColor: WHITE_COLOR,
                style: MainTextStyle().define(),
                // autofocus: true,
                focusNode: _searchInputFocusNode,
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey)
                )
              ),
              width: !inputIsActive ? 0 : MediaQuery.of(context).size.width - 140,
            ),
            Text(!inputIsActive ? title : ""),
          ],
        ),
        actions: getActionButtos(context),
        leading: getLeadingButton(context),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: getBoxes(context),
        )
      ),
      backgroundColor: BLACK_COLOR,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToAddBoxScreen(context),
        tooltip: 'Add new box',
        child: Icon(Icons.add, color: Colors.white, size: 28,),
        heroTag: 'btn1',
      ),
    );
  }
}
