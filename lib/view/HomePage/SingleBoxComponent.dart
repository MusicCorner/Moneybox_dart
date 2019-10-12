import 'package:clicker/common/styles/MainTextStyle.dart';
import 'package:clicker/constants/colors.dart';
import 'package:clicker/states/DetailBoxScreenStateful.dart';
import 'package:flutter/material.dart';

class SingleBoxComponent extends StatelessWidget {
  final box;
  final Function toggleBoxSelection;
  final bool checkBoxIsShowed;

  SingleBoxComponent({ this.box, this.toggleBoxSelection, this.checkBoxIsShowed, });

  void _selectBox() {
    if (box.id != 0) {
      toggleBoxSelection(box.id, true);
    }
  }

  void _toggleCheckBox(isSelected) {
    if (box.id != 0) {
      toggleBoxSelection(box.id, isSelected);
    }
  }

  void _goToBox(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailBoxScreenStateful(box: box)));
  }

  void _onTap(context) {
    if (checkBoxIsShowed && box.id != 0) {
      _toggleCheckBox(!box.isSelected);
    } else if (!checkBoxIsShowed) {
      _goToBox(context);
    }
  }

  Widget _getCheckBox() {
    if (checkBoxIsShowed) {
      return Container(
        height: 15.0,
        width: 29.0,
        child: Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: box.id != 0 ? _toggleCheckBox : (isSelected) => {},
          value: box.id != 0 ? box.isSelected : false
        ),
      );
    }

    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    String cachedAlready = box.cachedAlready.toString();
    // String sumToCache = box.sumToCache.toString();

    Widget rowContainer = Container(
      padding: EdgeInsets.only(left: 10, top: 17, right: 10, bottom: 17),
      child: Row(children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Text(box.name, style: MainTextStyle().define()),
              checkBoxIsShowed ? _getCheckBox() : Text(cachedAlready, style: MainTextStyle(fontSize: 15).define()),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        )
      ],),
    );

    return Container(
      decoration: BoxDecoration(color: MAIN_GREY_DARK_COLOR, border: Border(bottom: BorderSide(color: BLACK_COLOR))),
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          focusColor: ORANGE_BRIGHT_COLOR,
          highlightColor: ORANGE_BRIGHT_COLOR,
          hoverColor: ORANGE_BRIGHT_COLOR,
          splashColor: ORANGE_BRIGHT_COLOR,
          onTap: () => _onTap(context),
          onLongPress: _selectBox,
          child: rowContainer
        ),
      )
    );
  }
}
