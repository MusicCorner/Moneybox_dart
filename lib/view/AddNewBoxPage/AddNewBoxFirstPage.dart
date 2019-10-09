import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/scratches/SingleBox.dart';
import 'package:clicker/states/AddNewBoxFirstPageStateful.dart';
import 'package:clicker/states/AddNewBoxSecondPageStateful.dart';
import 'package:clicker/view/AddNewBoxPage/AddNewBoxBodyForm.dart';
import 'package:clicker/view/AddNewBoxPage/Common/NamedInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBoxFirstPage extends State<AddNewBoxFirstPageStateful> {
  final BoxesModel boxesModel;
  SingleBox currentBox;

  AddNewBoxFirstPage({ Key key, this.boxesModel });

  @override
  void initState() {
    currentBox = SingleBox(name: '', id: boxesModel.boxes.length);
    print(currentBox);
    super.initState();
  }

  _changeName(String name) {
    setState(() {
      currentBox.setName(name);
    });
  }

  void _changeSumToCache(String sumToCache) {
    setState(() {
      currentBox.setSumToCache(int.parse(sumToCache));
    });
  }

  void _changeAlreadyCachedSum(String alreadyCached) {
    setState(() {
      currentBox.setAlreadyCachedSum(int.parse(alreadyCached));
    });
  }

  void _goToNextPage(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewBoxSecondPageStateful(boxesModel: boxesModel, currentBox: currentBox,)));
  }

  Widget _getFloatingActionButton() {
    if (currentBox.name != '' && currentBox.sumToCache > 0) {
      return FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.navigate_next, color: Colors.white,),
        ),
        onPressed: () => _goToNextPage(context),
      );
    }

    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> namedInputsList = [
      NamedInput(onChanged: _changeName, title: 'Box name', hintText: 'Car'),
      NamedInput(onChanged: _changeSumToCache, title: 'Sum to cache', hintText: '10 000', keyBoardType: TextInputType.number),
      NamedInput(onChanged: _changeAlreadyCachedSum, title: 'Cached already', hintText: '1000', keyBoardType: TextInputType.number),
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
      floatingActionButton: _getFloatingActionButton()
      
    );
  }
}
