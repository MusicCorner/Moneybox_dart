import 'package:clicker/myTheme.dart';
// import 'package:clicker/states/AddNewBoxState.dart';
import 'package:clicker/states/HomePageStateful.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moneybox',
      theme: myTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePageStateful(title: 'Moneyboxes'),
        // '/addNewBox': (context) => AddNewBoxState(),
      },
    );
  }
}
