import 'dart:core';

/// Utility class for date-related functions and conversions.
abstract class DateFunctions {
  /// Hijri numbers list for Rohingya language.
  static const List<String> hijriNumbers = <String>[
    '𐴰',
    '𐴱',
    '𐴲',
    '𐴳',
    '𐴴',
    '𐴵',
    '𐴶',
    '𐴷',
    '𐴸',
    '𐴹'
  ];

  /// Get the last day of the current month for a given [currentMonth].
  static DateTime getLastDayOfCurrentMonth({required DateTime currentMonth}) {
    final DateTime firstDayOfNextMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 1);
    final DateTime lastDayOfCurrentMonth =
        firstDayOfNextMonth.subtract(const Duration(days: 1));
    return lastDayOfCurrentMonth;
  }

  /// Convert English integer [numbers] to Hijri script numbers.
  static String convertEnglishToHijriNumber(int numbers) {
    String hijriNumber = "";
    '$numbers'.split('').forEach((String char) {
      hijriNumber = "$hijriNumber${hijriNumbers[int.parse(char)]}";
    });
    return hijriNumber;
  }

  /// Localize an integer [number] based on the provided [locale].
  static String localizeNumber(int number, String locale) {
    if (locale == 'rhg') {
      return convertEnglishToHijriNumber(number);
    } else if (locale == 'ar') {
      const List<String> arabicNumbers = <String>[
        '٠',
        '١',
        '٢',
        '٣',
        '٤',
        '٥',
        '٦',
        '٧',
        '٨',
        '٩'
      ];
      String res = "";
      '$number'.split('').forEach((String char) {
        res = "$res${arabicNumbers[int.parse(char)]}";
      });
      return res;
    } else {
      return number.toString();
    }
  }
}
