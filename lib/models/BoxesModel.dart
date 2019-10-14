import 'dart:collection';
import 'package:clicker/common/sharedPreferences/boxHistory.dart';
import 'package:clicker/common/sharedPreferences/boxes.dart';
import 'package:clicker/models/SingleBox.dart';
import 'package:flutter/foundation.dart';

class BoxesModel extends ChangeNotifier {
  static final initialBoxItem = SingleBox(startDate: DateTime.now(), endDate: DateTime.now());

  List<SingleBox> _boxes = [initialBoxItem];

  UnmodifiableListView get boxes => UnmodifiableListView(_boxes);

  SingleBox getBoxViaItemWithSelect (item, isSelected) {
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

  void initBoxesFromStorage() async {
    _boxes = await getBoxesFromStorage();

    notifyListeners();
  }

  void addNewBox(SingleBox boxModel) async {
    _boxes.add(boxModel);
    updateBoxes(_boxes);
  }

  void deleteBoxes(List boxesId) {
    boxesId.forEach((boxId) {
      _boxes.removeWhere((item) => item.id == boxId);
      deleteBoxHistoryById(boxId);
    });

    updateBoxes(_boxes);
    notifyListeners();
  }

  void editBox(SingleBox boxToUpdateListWith) {
    _boxes = _boxes.map((box) => box.id == boxToUpdateListWith.id ? boxToUpdateListWith : box).toList();

    updateBoxes(_boxes);
    notifyListeners();
  }

  void toggleBoxSelection(int id, bool isSelected) {
    _boxes = _boxes.map<SingleBox>((item) => item.id == id ? getBoxViaItemWithSelect(item, isSelected) : item).toList();
    notifyListeners();
  }

  void toggleAllBoxesSelection(bool isSelected) {
    _boxes = _boxes.map((item) => getBoxViaItemWithSelect(item, isSelected)).toList();
    notifyListeners();
  }
}
