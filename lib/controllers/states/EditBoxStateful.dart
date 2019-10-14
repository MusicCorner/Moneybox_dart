import 'package:clicker/models/SingleBox.dart';
import 'package:clicker/view/SingleBoxForm/EditBoxPage/EditBoxPage.dart';
import 'package:flutter/widgets.dart';

class EditBoxStateful extends StatefulWidget {
  final SingleBox box;

  EditBoxStateful({ this.box });

  @override EditBoxPage createState() => EditBoxPage(box: box);
}