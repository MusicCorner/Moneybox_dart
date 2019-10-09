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
