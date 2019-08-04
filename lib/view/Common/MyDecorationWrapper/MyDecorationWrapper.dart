import 'package:flutter/material.dart';

class MyDecorationWrapper extends StatelessWidget {
  final Widget child;
  final BoxDecoration decoration;

  static BoxDecoration defaultDecoration = BoxDecoration(color: Colors.black);

  MyDecorationWrapper({
    this.child,
    decoration,
  }) : decoration = defaultDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: child,
    );

    // return Expanded(
    //   flex: 1,
    //   child: Container(
    //     child: child,
    //     decoration: decoration
    //   ),
    // );
  }
}
