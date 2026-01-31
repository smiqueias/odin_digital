extension DateTimeExtensions on DateTime {
  /// Checks if two DateTime objects represent the same calendar date (ignoring time).
  bool isDateEquals(DateTime other) => year == other.year && month == other.month && day == other.day;

  bool isDateAfterOrEquals(DateTime other) {
    final currentRawDate = _extractRawDate(this);
    final otherRawDate = _extractRawDate(other);
    return currentRawDate.isAfter(otherRawDate) || isDateEquals(other);
  }

  bool isDateBeforeOrEquals(DateTime other) {
    final currentRawDate = _extractRawDate(this);
    final otherRawDate = _extractRawDate(other);
    return currentRawDate.isBefore(otherRawDate) || isDateEquals(other);
  }

  bool isDateInPeriod(DateTime start, DateTime end) {
    return isDateAfterOrEquals(start) && isDateBeforeOrEquals(end);
  }

  DateTime _extractRawDate(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}
