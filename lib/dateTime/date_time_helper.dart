String convertDateTimeToString(DateTime dateTime) {
  // day format = dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0' + day;
  }

  // month format = mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0' + month;
  }

  // year format = yyyy
  String year = dateTime.year.toString();

  // combine ddmmyyyy

  String ddmmyyyy = day + month + year;

  return ddmmyyyy;
}
