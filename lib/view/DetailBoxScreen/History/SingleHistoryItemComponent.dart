import 'package:clicker/constants/colors.dart';
import 'package:clicker/scratches/SingleHistoryItem.dart';
import 'package:flutter/widgets.dart';

class SingleHistoryItemComponent extends StatelessWidget {
  final SingleHistoryItem historyItem;

  SingleHistoryItemComponent({ this.historyItem });

  String _getParsedMonthOrDay(int toParse) {
    return toParse > 9 ? '$toParse' : '0$toParse';
  }

  String _getCreatedAtString() {
    DateTime createdAt = historyItem.createdAt;
    String month = _getParsedMonthOrDay(createdAt.month);
    String day = _getParsedMonthOrDay(createdAt.day);

    return '${createdAt.year}/$month/$day';
  }

  TextStyle _getMainTextStyle() => TextStyle(color: WHITE_COLOR, fontSize: 15);

  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Row(
          children: <Widget>[
            Text(historyItem.value, style: _getMainTextStyle()),
            Text(_getCreatedAtString(), style: _getMainTextStyle())
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        margin: EdgeInsets.only(bottom: 15),
      )
    );
  }
}