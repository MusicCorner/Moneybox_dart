import 'package:clicker/constants/colors.dart';
import 'package:clicker/scratches/SingleHistoryItem.dart';
import 'package:clicker/view/DetailBoxScreen/History/SingleHistoryItemComponent.dart';
import 'package:flutter/widgets.dart';

class HistoryComponent extends StatelessWidget {
  final List<SingleHistoryItem> history;

  HistoryComponent({ this.history });

  List<Widget> _getHistoryWidgetList() {
    history.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    List<Widget> listToReturn = history.map<Widget>((historyItem) => (
      SingleHistoryItemComponent(historyItem: historyItem)
    )).toList();

    return listToReturn;
  }

  Widget build(BuildContext context) {
    if (history.length == 0) {
      return Text('');
    }

    return Expanded(
      child: Container(      
      // margin: EdgeInsets.only(top: 10),
        color: MAIN_GREY_DARK_COLOR,
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'History:',
                style: TextStyle(
                  color: WHITE_COLOR,
                  fontSize: 25
                )
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: BLACK_COLOR,
                  )
                )
              ),
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(bottom: 15),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  ..._getHistoryWidgetList(),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}