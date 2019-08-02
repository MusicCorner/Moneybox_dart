// import 'package:clicker/states/SingleBoxState.dart';
import 'package:flutter/material.dart';

class SingleBox extends StatelessWidget {
  SingleBox({ this.box, this.toggleBoxSelection, this.checkBoxIsShowed });
  
  final box;
  Function toggleBoxSelection;
  bool checkBoxIsShowed;

  void _selectBox() {
    toggleBoxSelection(box.id, true);
  }

  void _unselectBox() {
    toggleBoxSelection(box.id, false);
  }

  void _toggleCheckBox(isSelected) {
    toggleBoxSelection(box.id, isSelected);
  }

  Widget _getCheckBox() {
    if (checkBoxIsShowed) {
      return Checkbox(
        onChanged: box.id != 0 ? _toggleCheckBox : (isSelected) => {},
        value: box.id != 0 ? box.isSelected : false
      );
    }

    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unselectBox,
      onLongPress: _selectBox,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            _getCheckBox(),
            Text(box.name),
            Text(box.cachedAlready.toString()),
          ],)
        ],
      ),
    );
  }
}
