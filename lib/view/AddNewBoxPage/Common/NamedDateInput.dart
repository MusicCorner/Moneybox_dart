import 'package:clicker/common/styles/MainTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NamedDateInput extends StatelessWidget {
  String title;
  String hintText;
  Function onTap;
  TextEditingController controller;
  bool enabled;

  NamedDateInput({ this.title, this.hintText, this.onTap, this.controller, this.enabled = true });

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
              onTap: onTap,
              enabled: enabled,
              readOnly: true,
              controller: controller,
              style: MainTextStyle().define(),
            )
          )
        ],
      )
    );
  }
}