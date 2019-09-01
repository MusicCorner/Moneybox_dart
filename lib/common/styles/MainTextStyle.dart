import 'package:clicker/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainTextStyle {
  final double fontSize;

  MainTextStyle({ this.fontSize });

  TextStyle define() {
    return TextStyle(color: WHITE_COLOR, fontSize: fontSize != null ? fontSize : 18);
  }
}