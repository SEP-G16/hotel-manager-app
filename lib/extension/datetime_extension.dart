extension DatetimeExtension on DateTime{
  String toIsoFormattedDateTime() {
    return this.toIso8601String().split('T').first;
  }
}