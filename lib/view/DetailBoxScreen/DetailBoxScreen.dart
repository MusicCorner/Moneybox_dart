import 'package:clicker/common/sharedPreferences/updateBoxes.dart';
import 'package:clicker/constants/colors.dart';
import 'package:clicker/scratches/SingleBox.dart';
import 'package:clicker/view/DetailBoxScreen/PaymentsAlertDialog/PaymentsAlertDialog.dart';
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

  void _closeDialog(context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  void _addPaymentsAndCloseDialog(int value, context) {
    if (value != null) {
      box.addPaymentsToCachedAlready(value);
      updateSingleBox(box);
    }

    _closeDialog(context);
  }

  void _subtractPaymentsAndCloseDialog(int value, context) {
    if (value != null) {
      box.subtractPaymantsFromCachedAlready(value);
      updateSingleBox(box);
    }

    _closeDialog(context);
  }

  void _showAddPaymentsDialog(context) {
    int paymentsToAdd;
    void onChanged(value) {
      paymentsToAdd = int.parse(value);
    }

    void onSubmit() {
      _addPaymentsAndCloseDialog(paymentsToAdd, context);
    }

    void onCancel() {
      _closeDialog(context);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => PaymenstAlertDialog(
        onChanged: onChanged,
        onCancel: onCancel,
        onSubmit: onSubmit,
      ),
    );
  }

  void _showSubtractPaymentsDialog(context) {
    int paymentsToSubtract;
    void onChanged(value) {
      paymentsToSubtract = int.parse(value);
    }

    void onSubmit() {
      _subtractPaymentsAndCloseDialog(paymentsToSubtract, context);
    }

    void onCancel() {
      _closeDialog(context);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => PaymenstAlertDialog(
        onChanged: onChanged,
        onCancel: onCancel,
        onSubmit: onSubmit,
      ),
    );
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
    switch (value) {
      case 1:
        _showAddPaymentsDialog(context);
        break;

      case 2:
        _showSubtractPaymentsDialog(context);
        break;

      default:
        break;
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
