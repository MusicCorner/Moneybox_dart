String _getParsedMonthOrDay(int toParse) {
    return toParse > 9 ? '$toParse' : '0$toParse';
  }

getDefaultFormatedDateString(DateTime date) {
  String month = _getParsedMonthOrDay(date.month);
  String day = _getParsedMonthOrDay(date.day);

  return '${date.year}/$month/$day';
}