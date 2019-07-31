import 'package:clicker/MyApp.dart';
import 'package:clicker/models/BoxesModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class BoxesController extends ChangeNotifierProvider {
//   BoxesController() : super(
//     builder: (context) => BoxesModel(),
//     child: MyApp(),
//   );
// }

final boxesController = ChangeNotifierProvider(
  builder: (context) => BoxesModel(),
  child: MyApp(),
);
