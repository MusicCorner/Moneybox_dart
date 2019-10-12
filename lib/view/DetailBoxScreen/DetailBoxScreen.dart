import 'package:clicker/common/date.dart';
import 'package:clicker/common/sharedPreferences/boxHistory.dart';
import 'package:clicker/common/sharedPreferences/boxes.dart';
import 'package:clicker/constants/colors.dart';
import 'package:clicker/scratches/SingleBox.dart';
import 'package:clicker/scratches/SingleHistoryItem.dart';
import 'package:clicker/states/DetailBoxScreenStateful.dart';
import 'package:clicker/states/EditBoxStateful.dart';
import 'package:clicker/view/DetailBoxScreen/History/HistoryComponent.dart';
import 'package:clicker/view/DetailBoxScreen/PaymentsAlertDialog/PaymentsAlertDialog.dart';
import 'package:clicker/view/DetailBoxScreen/ProgressBar/ProgressBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailBoxScreen extends State<DetailBoxScreenStateful> {
  final SingleBox box;
  List<SingleHistoryItem> _history = [];

  DetailBoxScreen({ @required this.box });

  @override
  initState() {
    _updateHistory();
    super.initState();
  }

  void _updateHistory() async {
    _history = await getBoxHistoryById(box.id);
    setState(() {});
  }

  _addHistoryItem(String value) {
    DateTime createdAt = DateTime.now();
    SingleHistoryItem historyItemToAdd = SingleHistoryItem(
      createdAt: createdAt,
      value: value
    );

    _history.add(historyItemToAdd);
    updateBoxHistoryViaId(_history, box.id);
  }

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
      _addHistoryItem('+ $value');
    }

    _closeDialog(context);
  }

  void _subtractPaymentsAndCloseDialog(int value, context) {
    if (value != null) {
      box.subtractPaymantsFromCachedAlready(value);
      updateSingleBox(box);
      _addHistoryItem('- $value');
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

  _goToEditBoxScreen(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditBoxStateful(box: box)));
  }

  List<DropdownMenuItem> _getDropDownMenuItems() {
    return [
      DropdownMenuItem(
        child: Text('Edit box'),
        value: 1,
      ),
      DropdownMenuItem(
        child: Text('Add payments'),
        value: 2,
      ),
      DropdownMenuItem(
        child: Text('Subtract payments'),
        value: 3,
      ),
    ];
  }

  _onChangeDropDown(context) => (value) {
    switch (value) {
      case 1:
        _goToEditBoxScreen(context);
        break;

      case 2:
        _showSubtractPaymentsDialog(context);
        break;

      case 3:
        _showAddPaymentsDialog(context);
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
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Container(
              color: MAIN_GREY_DARK_COLOR,
              margin: EdgeInsets.only(bottom: 40),
              padding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
              child: Column(
                children: <Widget>[
                  ProgressBar(progressPercent: progressBarPercentage),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(box.cachedAlready.toString(), style: TextStyle(color: WHITE_COLOR)),
                            Text(getDefaultFormatedDateString(box.startDate), style: TextStyle(color: WHITE_COLOR)),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        Column(
                          children: <Widget>[
                            Text(box.sumToCache.toString(), style: TextStyle(color: WHITE_COLOR)),
                            Text(getDefaultFormatedDateString(box.endDate), style: TextStyle(color: WHITE_COLOR)),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.end,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ],
              )
            ),
            HistoryComponent(history: _history),
          ],
        )
      ),
    );
  }
}
