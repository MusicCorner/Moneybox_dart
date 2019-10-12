import 'dart:collection';
import 'dart:convert';
import 'package:clicker/scratches/SingleBox.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoxesModel extends ChangeNotifier {
  static final initialBoxItem = SingleBox(startDate: DateTime.now(), endDate: DateTime.now());
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

  void initBoxesFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    List<String> jsonedBoxesList = prefs.getStringList('boxes');
    if (jsonedBoxesList != null) {
      _boxes = jsonedBoxesList.map((jsonedBox) {
        var decodedJson = jsonDecode(jsonedBox);
        return new SingleBox.fromJson(decodedJson);
      }).toList();
    }

    notifyListeners();
  }

  void addNewBox(SingleBox boxModel) async {
    _boxes.add(boxModel);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> boxesStringList = _boxes.map((box) => jsonEncode(box)).toList();
    prefs.setStringList('boxes', boxesStringList);
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
