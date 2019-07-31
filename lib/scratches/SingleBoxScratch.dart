class SingleBoxScratch {
  String name;
  int id;
  int sumToCache;
  int cachedAlready;
  DateTime startDate;
  DateTime endDate;

  final DateTime currentDate = DateTime.now();

  SingleBoxScratch() {
    name = 'Other';
    id = 0;
    sumToCache = 0;
    cachedAlready = 0;
    startDate = currentDate;
    endDate = currentDate;
  }
}
