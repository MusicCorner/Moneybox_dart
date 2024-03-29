import 'package:clicker/common/styles/MainTextStyle.dart';
import 'package:flutter/material.dart';

class NamedInput extends StatelessWidget {
  final Function onChanged;
  final String title;
  final String hintText;
  final TextInputType keyBoardType;
  final TextEditingController controller;

  NamedInput({
    this.onChanged,
    this.title,
    this.hintText,
    this.keyBoardType = TextInputType.text,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return (
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: MainTextStyle().define()),
          Container(
            // color: MAIN_GREY_DARK_COLOR,
            margin: EdgeInsets.only(top: 10, bottom: 20),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[900], width: 2)),
                filled: true,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey)
              ),
              onChanged: onChanged,
              controller: controller,
              keyboardType: keyBoardType,
              style: MainTextStyle().define(),
            )
          )
        ],
      )
    );
  }
}