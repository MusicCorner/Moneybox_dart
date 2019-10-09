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

  Widget _getAlertWidget(BuildContext context) {
    return new AlertDialog(
      title: Text('Add payments'),
    );
  }

  void _addPaymentToCache(context) {
    showDialog(context: context, builder: (BuildContext context) => _getAlertWidget(context));
  }

  @override
  Widget build(BuildContext context) {
    double progressBarPercentage = _getProgressBarPercantage();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(box.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: WHITE_COLOR),
            color: WHITE_COLOR,
            onPressed: () => _addPaymentToCache(context),
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