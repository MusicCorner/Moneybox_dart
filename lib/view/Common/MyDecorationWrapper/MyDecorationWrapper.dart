import 'package:flutter/material.dart';

class MyDecorationWrapper extends StatelessWidget {
  final Widget child;
  final BoxDecoration decoration;
  final EdgeInsets padding;

  static BoxDecoration defaultDecoration = BoxDecoration(color: Colors.black);

  MyDecorationWrapper({
    this.child,
    this.padding,
    decoration,
  }) : decoration = defaultDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: child,
      padding: padding != null ? padding : EdgeInsets.all(0),
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
