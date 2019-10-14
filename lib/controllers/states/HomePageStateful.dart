import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/view/HomePage/HomePage.dart';
import 'package:flutter/widgets.dart';

class HomePageStateful extends StatefulWidget {
  BoxesModel boxesModel;

  HomePageStateful({
    Key key,
    this.boxesModel,
  }) : super(key: key);

  @override
  HomePage createState() => HomePage(boxesModel: boxesModel);
}