import 'dart:convert';

import 'package:clicker/models/SingleHistoryItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

void updateBoxHistoryViaId(List<SingleHistoryItem> historyArrayToSet, int boxId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> historyStringList = historyArrayToSet.map((historyItem) => jsonEncode(historyItem)).toList();
  prefs.setStringList('box_${boxId}_history', historyStringList);
}

Future<List> getBoxHistoryById(int boxId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> jsonedBoxesList = prefs.getStringList('box_${boxId}_history');

  if (jsonedBoxesList != null) {
    List<SingleHistoryItem> decodedList = jsonedBoxesList.map((jsonedBox) {
      return SingleHistoryItem.fromJson(jsonDecode(jsonedBox));
    }).toList();

    return decodedList;
  }

  List<SingleHistoryItem> emptyListToReturn = [];

  return emptyListToReturn;
}

void deleteBoxHistoryById(int boxId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('box_${boxId}_history');
}