import 'package:clicker/models/SingleBox.dart';
import 'package:clicker/view/DetailBoxScreen/DetailBoxScreen.dart';
import 'package:flutter/cupertino.dart';

class DetailBoxScreenStateful extends StatefulWidget {
  final SingleBox box;

  DetailBoxScreenStateful({ this.box });

  @override
  DetailBoxScreen createState() => DetailBoxScreen(box: box);
}