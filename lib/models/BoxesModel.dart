import 'dart:collection';
import 'package:clicker/scratches/SingleBox.dart';
import 'package:flutter/foundation.dart';

class BoxesModel extends ChangeNotifier {
  static final initialBoxItem = SingleBox();
  // static final testBox = SingleBox(name: 'Thailand', id: 1, sumToCache: 60000, cachedAlready: 22000);
  // static final testBox1 = SingleBox(name: 'Test box to delete1', id: 2);
  // static final testBox2 = SingleBox(name: 'Test box to delete2', id: 3);

  List _boxes = [initialBoxItem];

  UnmodifiableListView get boxes => UnmodifiableListView(_boxes);

  static getBoxViaItemWithSelect (item, isSelected) {
    return SingleBox(
      name: item.name,
      id: item.id,
      isSelected: isSelected,
      sumToCache: item.sumToCache,
      cachedAlready: item.cachedAlready,
      startDate: item.startDate,
      endDate: item.endDate,
    );
  }

  void addNewBox(SingleBox boxModel) {
    _boxes.add(boxModel);
  }

  void deleteBoxes(List boxesId) {
    boxesId.forEach((boxId) => {
      _boxes.removeWhere((item) => item.id != 0 && item.id == boxId)
    });
    notifyListeners();
  }

  void toggleBoxSelection(int id, bool isSelected) {
    _boxes = _boxes.map((item) => item.id == id ? getBoxViaItemWithSelect(item, isSelected) : item).toList();
    notifyListeners();
  }

  void toggleAllBoxesSelection(bool isSelected) {
    _boxes = _boxes.map((item) => getBoxViaItemWithSelect(item, isSelected)).toList();
    notifyListeners();
  }
}
