import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/myTheme.dart';
import 'package:clicker/controllers/states/HomePageStateful.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moneybox',
      theme: myTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => Consumer<BoxesModel>(
          builder: (consumerContext, BoxesModel boxesModel, child) => HomePageStateful(boxesModel: boxesModel)
        ),
      },
    );
  }
}
