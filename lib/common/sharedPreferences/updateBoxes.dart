import 'dart:convert';
import 'package:clicker/scratches/SingleBox.dart';
import 'package:shared_preferences/shared_preferences.dart';

void updateBoxes(List<SingleBox> boxesList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> boxesStringList = boxesList.map((box) => jsonEncode(box)).toList();
  prefs.setStringList('boxes', boxesStringList);
}

void updateSingleBox(SingleBox box) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String encodedBoxToUpdate = jsonEncode(box);

  List<String> boxesListFromStorage = prefs.getStringList('boxes');
  List<String> boxesListToSet = boxesListFromStorage.map((jsonedBox) {
    SingleBox decodedBox = SingleBox.fromJson(jsonDecode(jsonedBox));

    if (decodedBox.id == box.id) {
      return encodedBoxToUpdate;
    }

    return jsonedBox;
  }).toList();

  prefs.setStringList('boxes', boxesListToSet);
}