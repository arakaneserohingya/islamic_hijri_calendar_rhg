/// Model class for Hijri date datatype to manage date.
class HijriDate {
  /// The year part of the Hijri date.
  final String year;

  /// The month part of the Hijri date.
  final String month;

  /// The day part of the Hijri date.
  final String day;

  /// Creates a new [HijriDate].
  HijriDate({
    required this.year,
    required this.month,
    required this.day,
  });

  @override
  String toString() {
    return '$day-$month-$year';
  }
}
