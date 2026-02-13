import 'dart:core';

abstract class DateFunctions {
  ///Hijri numbers list
  static const List<String> hijriNumbers = [
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

  ///get last date of current showed month
  static DateTime getLastDayOfCurrentMonth({required DateTime currentMonth}) {
    DateTime firstDayOfNextMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 1);
    DateTime lastDayOfCurrentMonth =
        firstDayOfNextMonth.subtract(const Duration(days: 1));
    return lastDayOfCurrentMonth;
  }

  ///Convert english to hijri n numbers
  static String convertEnglishToHijriNumber(int numbers) {
    String hijriNumber = "";
    '$numbers'.split('').forEach((char) {
      hijriNumber = "$hijriNumber${hijriNumbers[int.parse(char)]}";
    });
    return hijriNumber;
  }

  static String localizeNumber(int number, String locale) {
    if (locale == 'rhg') {
      return convertEnglishToHijriNumber(number);
    } else if (locale == 'ar') {
      // Manual conversion to Arabic indic digits if intl formatting is not desired or sufficient
      const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
      String res = "";
      '$number'.split('').forEach((char) {
        res = "$res${arabicNumbers[int.parse(char)]}";
      });
      return res;
    } else {
      return number.toString();
    }
  }
}
