import 'package:flutter/foundation.dart';

class SingleBox {
  String name;
  int id;
  bool isSelected;
  int sumToCache;
  int cachedAlready;
  DateTime startDate;
  DateTime endDate;

  SingleBox({
    Key key,
    this.name = 'Other',
    this.id = 0,
    this.isSelected = false,
    this.sumToCache = 0,
    this.cachedAlready = 0,
    this.startDate,
    this.endDate,
  });

  factory SingleBox.fromJson(Map<String, dynamic> json) {
    return new SingleBox(
      name: json['name'],
      id: json['id'],
      isSelected: json['isSelected'],
      sumToCache: json['sumToCache'],
      cachedAlready: json['cachedAlready'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'isSelected': isSelected,
    'sumToCache': sumToCache,
    'cachedAlready': cachedAlready,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
  };

  void setName(String nameToSet) {
    name = nameToSet;
  }

  void setIsSelectedFlag(bool isSelectedToSet) {
    isSelected = isSelectedToSet;
  }

  void setSumToCache(int sumToCacheToSet) {
    sumToCache = sumToCacheToSet;
  }

  void setAlreadyCachedSum(int alreadyCachedToSet) {
    cachedAlready = alreadyCachedToSet;
  }

  void setStartDate(DateTime startDateToSet) {
    startDate = startDateToSet;
  }

  void setEndDate(DateTime endDateToSet) {
    endDate = endDateToSet;
  }
}
