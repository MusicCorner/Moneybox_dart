import 'package:flutter/foundation.dart';

class SingleBoxScratch {
  String name;
  int id;
  bool isSelected;
  int sumToCache;
  int cachedAlready;
  DateTime startDate;
  DateTime endDate;

  static DateTime currentDate = DateTime.now();

  SingleBoxScratch({
    Key key,
    this.name = 'Other',
    this.id = 0,
    this.isSelected = false,
    this.sumToCache = 0,
    this.cachedAlready = 0,
    this.startDate,
    this.endDate
  });
}
