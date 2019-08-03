import 'dart:ui';
import 'package:flutter/material.dart';

class SingleBox extends StatelessWidget {
  SingleBox({ this.box, this.toggleBoxSelection, this.checkBoxIsShowed });
  
  final box;
  Function toggleBoxSelection;
  bool checkBoxIsShowed;

  void _selectBox() {
    if (box.id != 0) {
      toggleBoxSelection(box.id, true);
    }
  }

  void _unselectBox() {
    toggleBoxSelection(box.id, false);
  }

  void _toggleCheckBox(isSelected) {
    if (box.id != 0) {
      toggleBoxSelection(box.id, isSelected);
    }
  }

  void _onTap() {
    if (checkBoxIsShowed && box.id != 0) {
      _toggleCheckBox(!box.isSelected);
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
    String sumToCache = box.sumToCache.toString();
    double textBoxWidth = checkBoxIsShowed ? MediaQuery.of(context).size.width * 0.84 : MediaQuery.of(context).size.width * 0.92;

    Widget rowContainer = Container(
      padding: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      decoration: BoxDecoration(color: Color(0xFF171717), border: Border(bottom: BorderSide(color: Colors.black))),
      child: Row(children: <Widget>[
        _getCheckBox(),
        Container(
          child: Row(
            children: <Widget>[
              Text(box.name, style: TextStyle(color: Colors.white)),
              Text(cachedAlready, style: TextStyle(color: Colors.white)),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          width: textBoxWidth,
        )
      ],),
    );

    return GestureDetector(
      onTap: _onTap,
      onLongPress: _selectBox,
      child: rowContainer
    );
  }
}
