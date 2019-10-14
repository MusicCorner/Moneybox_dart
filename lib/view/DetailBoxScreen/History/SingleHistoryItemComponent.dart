import 'package:clicker/common/date.dart';
import 'package:clicker/constants/colors.dart';
import 'package:clicker/models/SingleHistoryItem.dart';
import 'package:flutter/widgets.dart';

class SingleHistoryItemComponent extends StatelessWidget {
  final SingleHistoryItem historyItem;

  SingleHistoryItemComponent({ this.historyItem });

  TextStyle _getMainTextStyle() => TextStyle(color: WHITE_COLOR, fontSize: 15);

  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Row(
          children: <Widget>[
            Text(historyItem.value, style: _getMainTextStyle()),
            Text(getDefaultFormatedDateString(historyItem.createdAt), style: _getMainTextStyle())
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        margin: EdgeInsets.only(bottom: 15),
      )
    );
  }
}