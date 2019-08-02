import 'package:flutter/foundation.dart';

class SingleBoxScratch {
  String name;
  int id;
  bool isSelected;
  int sumToCache;
  int cachedAlready;
  final DateTime startDate;
  final DateTime endDate;

  static DateTime currentDate = DateTime.now();

  SingleBoxScratch({
    Key key,
    this.name = 'Other',
    this.id = 0,
    this.isSelected = false,
    this.sumToCache = 0,
    this.cachedAlready = 0,
    DateTime startDate,
    DateTime endDate
  }) : startDate = currentDate, endDate = currentDate;
}
