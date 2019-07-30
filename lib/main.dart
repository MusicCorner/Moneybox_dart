import 'package:clicker/AddNewBoxPage.dart';
import 'package:clicker/myTheme.dart';
import 'package:flutter/material.dart';
import './MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme,
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Home'),
        '/addNewBox': (context) => AddNewBoxPage(),
      },
    );
  }
}
