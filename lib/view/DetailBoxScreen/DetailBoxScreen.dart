import 'package:clicker/constants/colors.dart';
import 'package:clicker/scratches/SingleBox.dart';
import 'package:clicker/view/DetailBoxScreen/ProgressBar/ProgressBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailBoxScreen extends StatelessWidget {
  final SingleBox box;

  DetailBoxScreen({ Key key, @required this.box }) : super(key: key);

  double _getProgressBarPercantage() {
    if (box.sumToCache > 0) {
      return (box.cachedAlready * 100) / box.sumToCache;
    }
    return 0;
  }

  Widget _getAlertWidget(BuildContext context) => (
    new AlertDialog(
      title: Text('Add payments'),
    )
  );

  void _addPaymentToAlreadyCached(int value) {
    print(value);
  }

  void _closeDialog(context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  void _showAddPaymentsDialog(context) {
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
      title: Text('Add payments'),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => _closeDialog(context)
        ),
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            _addPaymentToAlreadyCached(10);
            _closeDialog(context);
          },
        )
      ],
    ));
  }

  List<DropdownMenuItem> _getDropDownMenuItems() {
    return [
      DropdownMenuItem(
        child: Text('Add payments'),
        value: 1,
      ),
      DropdownMenuItem(
        child: Text('Subtract payments'),
        value: 2,
      ),
      DropdownMenuItem(
        child: Text('Edit box'),
        value: 3,
      ),
    ];
  }

  _onChangeDropDown(context) => (value) {
    print(value);
    if (value == 1) {
      _showAddPaymentsDialog(context);
    }
  };

  @override
  Widget build(BuildContext context) {
    double progressBarPercentage = _getProgressBarPercantage();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(box.name),
        actions: <Widget>[
          Container(
            child: DropdownButton(
              items: _getDropDownMenuItems(),
              onChanged: _onChangeDropDown(context),
              icon: Icon(Icons.more_vert, color: WHITE_COLOR),
              iconSize: 24,
              underline: Container(
                height: 0,
              ),
            ),
            padding: EdgeInsets.all(10)
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        color: MAIN_GREY_DARK_COLOR,
        height: 140,
        margin: EdgeInsets.only(bottom: 40),
        child: Column(
          children: <Widget>[
            ProgressBar(progressPercent: progressBarPercentage),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Text(box.cachedAlready.toString(), style: TextStyle(color: WHITE_COLOR)),
                  Text(box.sumToCache.toString(), style: TextStyle(color: WHITE_COLOR),)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            )
          ],
        )
      ),
    );
  }
}