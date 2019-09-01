import 'package:clicker/common/styles/MainTextStyle.dart';
import 'package:clicker/constants/colors.dart';
import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/scratches/SingleBoxScratch.dart';
import 'package:clicker/states/AddNewBoxStateful.dart';
import 'package:clicker/view/Common/MyDecorationWrapper/MyDecorationWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBoxPage extends State<AddNewBoxStateful> {
  final BoxesModel boxesModel;
  SingleBoxScratch currentBox;

  AddNewBoxPage({ Key key, this.boxesModel });

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
      currentBox.sumToCache = int.parse(sumToCache);
    });
  }

  void _changeAlreadyCachedSum(String alreadyCached) {
    setState(() {
      currentBox.cachedAlready = int.parse(alreadyCached);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new box'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: MyDecorationWrapper(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Box name:', style: MainTextStyle().define(),),
              Container(
                // color: MAIN_GREY_DARK_COLOR,
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[900], width: 2)),
                    filled: true,
                    hintText: "Car",
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                  onChanged: _changeNameOfABox,
                  style: MainTextStyle().define(),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
