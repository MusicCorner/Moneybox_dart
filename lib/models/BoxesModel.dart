import 'dart:collection';
import 'package:clicker/scratches/SingleBoxScratch.dart';
import 'package:flutter/foundation.dart';

class BoxesModel extends ChangeNotifier {
  static final initialBoxItem = SingleBoxScratch();
  final List _boxes = [initialBoxItem];

  UnmodifiableListView get boxes => UnmodifiableListView(_boxes);

  void deleteBox(int id) {
    _boxes.removeWhere((item) => item.id != 0 && item.id == id);
    notifyListeners();
  }
}
