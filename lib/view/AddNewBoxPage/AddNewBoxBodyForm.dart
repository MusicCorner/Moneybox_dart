import 'package:clicker/view/Common/MyDecorationWrapper/MyDecorationWrapper.dart';
import 'package:flutter/widgets.dart';

class AddNewBoxBodyForm extends StatelessWidget {
  List<Widget> namedInputsList;
  
  AddNewBoxBodyForm({ this.namedInputsList });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyDecorationWrapper(
        padding: EdgeInsets.all(10),
        child: Column(
          children: namedInputsList,
        ),
      ),
    );
  }
}