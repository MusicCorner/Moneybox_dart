import 'dart:collection';
import 'package:clicker/scratches/SingleBoxScratch.dart';
import 'package:flutter/foundation.dart';

class BoxesModel extends ChangeNotifier {
  static final initialBoxItem = SingleBoxScratch();
  static final testBox = SingleBoxScratch(name: 'Thailand', id: 1, sumToCache: 60000, cachedAlready: 22000);
  static final testBox1 = SingleBoxScratch(name: 'Test box to delete1', id: 2);
  static final testBox2 = SingleBoxScratch(name: 'Test box to delete2', id: 3);

  List _boxes = [initialBoxItem, testBox, testBox1, testBox2];

  UnmodifiableListView get boxes => UnmodifiableListView(_boxes);

  static getBoxViaItemWithSelect (item, isSelected) {
    return SingleBoxScratch(
      name: item.name,
      id: item.id,
      isSelected: isSelected,
      sumToCache: item.sumToCache,
      cachedAlready: item.cachedAlready,
      startDate: item.startDate,
      endDate: item.endDate,
    );
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
