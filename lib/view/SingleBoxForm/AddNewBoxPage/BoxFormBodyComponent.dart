import 'package:clicker/view/Common/MyDecorationWrapper/MyDecorationWrapper.dart';
import 'package:flutter/widgets.dart';

class BoxFormBodyComponent extends StatelessWidget {
  List<Widget> namedInputsList;
  
  BoxFormBodyComponent({ this.namedInputsList });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: MyDecorationWrapper(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: namedInputsList,
            ),
          ),
        )
      ],
    );
  }
}