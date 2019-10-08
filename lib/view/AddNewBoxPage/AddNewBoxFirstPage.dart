import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/scratches/SingleBoxScratch.dart';
import 'package:clicker/states/AddNewBoxFirstPageStateful.dart';
import 'package:clicker/states/AddNewBoxSecondPageStateful.dart';
import 'package:clicker/view/AddNewBoxPage/AddNewBoxBodyForm.dart';
import 'package:clicker/view/AddNewBoxPage/Common/NamedInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBoxFirstPage extends State<AddNewBoxFirstPageStateful> {
  final BoxesModel boxesModel;
  SingleBoxScratch currentBox;

  AddNewBoxFirstPage({ Key key, this.boxesModel });

  @override
  void initState() {
    currentBox = SingleBoxScratch(name: '', id: boxesModel.boxes.length);
    print(currentBox);
    super.initState();
  }

  void _changeNameOfABox(String name) {
    setState(() {
      currentBox.name = name;
    });
  }

  void _changeSumToCache(String sumToCache) {
    setState(() {
      currentBox.sumToCache = sumToCache != '' ? int.parse(sumToCache) : 0;
    });
  }

  void _changeAlreadyCachedSum(String alreadyCached) {
    setState(() {
      currentBox.cachedAlready = int.parse(alreadyCached);
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
      NamedInput(onChanged: _changeNameOfABox, title: 'Box name', hintText: 'Car'),
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
