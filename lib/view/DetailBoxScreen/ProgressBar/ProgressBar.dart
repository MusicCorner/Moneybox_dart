import 'package:clicker/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progressPercent;
  ProgressBar({ Key key, this.progressPercent }) : super(key: key);

  double _getAbsoluteWidthViaContext(context) => (MediaQuery.of(context).size.width * progressPercent) / 100;

  @override
  Widget build(BuildContext context) {
    double progressWidth = _getAbsoluteWidthViaContext(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 40,
            color: PROGRESS_BAR_COLOR,
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: progressWidth,
                child: Container(
                  color: PROGRESS_BAR_FULFILL_COLOR,
                ),
              )
            )
          )
        )
      ],
    );
  }
}
