import 'package:intl/intl.dart';
import 'date_functions.dart';
import 'hijri_month_week_names.dart';

/// Configuration for the Hijri Calendar.
class HijriCalendarConfig {
  /// The current language for localization.
  static String language = 'rhg';

  /// The length of the current month.
  late int lengthOfMonth;

  /// The Hijri day.
  int hDay = 1;

  /// The Hijri month.
  late int hMonth;

  /// The Hijri year.
  late int hYear;

  /// The day of the week (1: Monday, ..., 7: Sunday).
  int? wkDay;

  /// Long month name (localized).
  late String longMonthName;

  /// Short month name (localized).
  late String shortMonthName;

  /// Day of the week name (localized).
  late String dayWeName;

  /// Optional adjustments for specific months.
  Map<int, int>? adjustments;

  static const Map<String, Map<String, Map<int, String>>> _local =
      <String, Map<String, Map<int, String>>>{
    'en': <String, Map<int, String>>{
      'long': monthNames,
      'short': monthShortNames,
      'days': wdNames,
      'short_days': shortWdNames
    },
    'rhg': <String, Map<int, String>>{
      'long': rhgMonthNames,
      'short': rhgMonthShortNames,
      'days': rhgWkNames,
      'short_days': rhgShortWdNames
    },
    'ar': <String, Map<int, String>>{
      'long': arMonthNames,
      'short': arMonthShortNames,
      'days': arWkNames,
      'short_days': arShortWdNames
    },
  };

  /// Islamic Events Map: Language -> Month -> {Day: Event Name}
  static const Map<String, Map<int, Map<int, String>>> islamicEvents =
      <String, Map<int, Map<int, String>>>{
    'rhg': <int, Map<int, String>>{
      1: <int, String>{1: '𐴕𐴝𐴘𐴝 𐴏𐴝𐴓', 10: '𐴀𐴝𐴆𐴟𐴌𐴝'},
      3: <int, String>{12: '𐴔𐴡𐴓𐴟𐴊 𐴕𐴡𐴁𐴞'},
      7: <int, String>{27: '𐴔𐴝𐴌𐴝𐴅'},
      8: <int, String>{15: '𐴏𐴡𐴁𐴠-𐴁𐴡𐴌𐴝𐴃'},
      9: <int, String>{1: '𐴌𐴡𐴔𐴎𐴝𐴕', 27: '𐴓𐴡𐴘𐴓𐴝𐴃𐴟𐴓 𐴒𐴡𐴊𐴡𐴌'},
      10: <int, String>{1: '𐴌𐴡𐴔𐴎𐴝𐴕𐴠 𐴍𐴞𐴊'},
      12: <int, String>{9: '𐴀𐴝𐴌𐴝𐴉𐴝 𐴊𐴞𐴕', 10: '𐴒𐴟𐴌𐴁𐴝𐴕𐴠 𐴍𐴞𐴊'},
    },
    'en': <int, Map<int, String>>{
      1: <int, String>{1: 'Islamic New Year', 10: 'Ashura'},
      3: <int, String>{12: 'Mawlid al-Nabi'},
      7: <int, String>{27: 'Isra and Mi\'raj'},
      8: <int, String>{15: 'Mid-Sha\'ban'},
      9: <int, String>{1: 'First of Ramadan', 27: 'Laylat al-Qadr'},
      10: <int, String>{1: 'Eid al-Fitr'},
      12: <int, String>{9: 'Day of Arafah', 10: 'Eid al-Adha'},
    },
    'ar': <int, Map<int, String>>{
      1: <int, String>{1: 'رأس السنة الهجرية', 10: 'عاشوراء'},
      3: <int, String>{12: 'المولد النبوي'},
      7: <int, String>{27: 'الإسراء والمعراج'},
      8: <int, String>{15: 'النصف من شعبان'},
      9: <int, String>{1: 'أول رمضان', 27: 'ليلة القدر'},
      10: <int, String>{1: 'عيد الفطر'},
      12: <int, String>{9: 'يوم عرفة', 10: 'عيد الأضحى'},
    }
  };

  /// Localized UI Strings
  static const Map<String, Map<String, String>> localizedStrings =
      <String, Map<String, String>>{
    'en': <String, String>{
      'events_title': 'Calendar Events',
      'no_events': 'No events this month',
    },
    'rhg': <String, String>{
      'events_title': '𐴑𐴠𐴓𐴠𐴕𐴊𐴝𐴌𐴡𐴌 𐴂𐴟𐴌𐴟𐴒𐴝𐴌𐴝𐴔',
      'no_events': '𐴇𐴡𐴕𐴥𐴡 𐴂𐴟𐴌𐴟𐴒𐴝𐴌𐴝𐴔 𐴕𐴥𐴝𐴘𐴢',
    },
    'ar': <String, String>{
      'events_title': 'أحداث التقويم',
      'no_events': 'لا توجد أحداث هذا الشهر',
    },
  };

  /// Get a localized string for a specific [key] and [locale].
  static String getLocalizedString(String locale, String key) {
    return localizedStrings[locale]?[key] ?? localizedStrings['en']![key]!;
  }

  ///set local language value
  factory HijriCalendarConfig.setLocal(String locale) {
    language = locale;
    return HijriCalendarConfig();
  }

  /// Default constructor for [HijriCalendarConfig].
  HijriCalendarConfig();

  ///set configuration by datetime
  HijriCalendarConfig.fromDate(DateTime date) {
    gregorianToHijri(date.year, date.month, date.day);
  }

  /// Initialize with current date.
  HijriCalendarConfig.now() {
    _now();
  }

  ///get localized short day names
  static Map<int, String> getShortDayNames(String locale) =>
      _local[locale]!['short_days']!;

  ///add month
  HijriCalendarConfig.addMonth(int year, int month) {
    hYear = month % 12 == 0 ? year - 1 : year;
    hMonth = month % 12 == 0 ? 12 : month % 12;
    hDay = 1;
  }

  ///get today hijri date
  String _now() {
    DateTime today = DateTime.now();
    return gregorianToHijri(today.year, today.month, today.day);
  }

  ///get days for particular month & year
  int getDaysInMonth(int year, int month) {
    int i = _getNewMoonMJDNIndex(year, month);
    return _ummalquraDataIndex(i)! - _ummalquraDataIndex(i - 1)!;
  }

  ///get modulo calculation
  int _gMod(int n, int m) {
    // generalized modulo function (n mod m) also valid for negative values of n
    return ((n % m) + m) % m;
  }

  ///get new moon index
  int _getNewMoonMJDNIndex(int hy, int hm) {
    int cYears = hy - 1, totalMonths = (cYears * 12) + 1 + (hm - 1);
    return totalMonths - 16260;
  }

  ///get length of year
  int lengthOfYear({int year = 0}) {
    int total = 0;
    int hYearValue = year == 0 ? hYear : year;
    for (int m = 1; m <= 12; m++) {
      total += getDaysInMonth(hYearValue, m);
    }
    return total;
  }

  ///convert hijri date to gregorian datetime
  DateTime hijriToGregorian(int year, int month, int day) {
    final int iy = year;
    final int im = month;
    final int id = day;
    final int ii = iy - 1;
    final int iln = (ii * 12) + 1 + (im - 1);
    final int i = iln - 16260;
    final int mcjdn = id + _ummalquraDataIndex(i - 1)! - 1;
    final int cjdn = mcjdn + 2400000;
    return julianToGregorian(cjdn);
  }

  ///convert julian to gregorian calendar
  DateTime julianToGregorian(int julianDate) {
    //source from: http://keith-wood.name/calendars.html
    final int z = (julianDate + 0.5).floor();
    int a = ((z - 1867216.25) / 36524.25).floor();
    a = z + 1 + a - (a / 4).floor();
    final int b = a + 1524;
    final int c = ((b - 122.1) / 365.25).floor();
    final int d = (365.25 * c).floor();
    final int e = ((b - d) / 30.6001).floor();
    final int day = b - d - (e * 30.6001).floor();
    //var wd = _gMod(julianDate + 1, 7) + 1;
    final int month = e - (e > 13.5 ? 13 : 1);
    int year = c - (month > 2.5 ? 4716 : 4715);
    if (year <= 0) {
      year--;
    } // No year zero
    return DateTime(year, (month), day);
  }

  ///convert gregorian to hijri date
  String gregorianToHijri(int pYear, int pMonth, int pDay) {
    //This code the modified version of R.H. van Gent Code, it can be found at http://www.staff.science.uu.nl/~gent0113/islam/ummalqura.htm
    // read calendar data

    int day = (pDay);
    int month =
        (pMonth); // -1; // Here we enter the Index of the month (which starts with Zero)
    int year = (pYear);

    int m = month;
    int y = year;

    // append January and February to the previous year (i.e. regard March as
    // the first month of the year in order to simplify leapday corrections)

    if (m < 3) {
      y -= 1;
      m += 12;
    }

    // determine offset between Julian and Gregorian calendar

    int a = (y / 100).floor();
    int jgc = a - (a / 4.0).floor() - 2;

    // compute Chronological Julian Day Number (CJDN)

    int cjdn = (365.25 * (y + 4716)).floor() +
        (30.6001 * (m + 1)).floor() +
        day -
        jgc -
        1524;

    a = ((cjdn - 1867216.25) / 36524.25).floor();
    jgc = a - (a / 4.0).floor() + 1;
    final int b = cjdn + jgc + 1524;
    int c = ((b - 122.1) / 365.25).floor();
    final int d = (365.25 * c).floor();
    month = ((b - d) / 30.6001).floor();
    day = (b - d) - (30.6001 * month).floor();

    if (month > 13) {
      c += 1;
      month -= 12;
    }

    month -= 1;
    year = c - 4716;

    // compute Modified Chronological Julian Day Number (MCJDN)

    final int mcjdn = cjdn - 2400000;

    // the MCJDN's of the start of the lunations in the Umm al-Qura calendar are stored in 'islamcalendar_dat.js'
    int i;
    for (i = 0; i < ummAlquraDateArray.length; i++) {
      if (_ummalquraDataIndex(i)! > mcjdn) break;
    }

    // compute and output the Umm al-Qura calendar date

    final int iln = i + 16260;
    final int ii = ((iln - 1) / 12).floor();
    final int iy = ii + 1;
    final int im = iln - 12 * ii;
    final int id = mcjdn - _ummalquraDataIndex(i - 1)! + 1;
    final int ml = _ummalquraDataIndex(i)! - _ummalquraDataIndex(i - 1)!;
    lengthOfMonth = ml;
    final int wd = _gMod(cjdn + 1, 7);

    wkDay = wd == 0 ? 7 : wd;
    return hDate(iy, im, id);
  }

  /// Returns a short formatted string using "dd/mm/yyyy".
  String hDate(int year, int month, int day) {
    hYear = year;
    hMonth = month;
    longMonthName = _local[language]!['long']![month]!;
    dayWeName = _local[language]!['days']![wkDay]!;
    shortMonthName = _local[language]!['short']![month]!;
    hDay = day;
    return format(hYear, hMonth, hDay, "dd/mm/yyyy");
  }

  ///format the text
  String toFormat(String format) {
    return this.format(hYear, hMonth, hDay, format);
  }

  ///format date time values to string
  String format(int year, int month, int day, String format) {
    String newFormat = format;

    String dayString;
    String monthString;
    String yearString;

    if (language == 'rhg') {
      dayString = DateFunctions.convertEnglishToHijriNumber(day);
      monthString = DateFunctions.convertEnglishToHijriNumber(month);
      yearString = DateFunctions.convertEnglishToHijriNumber(year);
    } else if (language == 'ar') {
      // Use Arabic numerals
      final NumberFormat f = NumberFormat("00", "ar");
      dayString = f.format(day);
      monthString = f.format(month);
      yearString = NumberFormat("0000", "ar").format(year);
    } else {
      dayString = day.toString();
      monthString = month.toString();
      yearString = year.toString();
    }

    if (newFormat.contains("dd")) {
      newFormat = newFormat.replaceFirst("dd", dayString);
    } else {
      if (newFormat.contains("d")) {
        newFormat = newFormat.replaceFirst("d", day.toString());
      }
    }

    ///day name
    // Friday
    if (newFormat.contains("DDDD")) {
      newFormat = newFormat.replaceFirst(
          "DDDD", "${_local[language]!['days']![wkDay ?? weekDay()]}");

      // Fri
    } else if (newFormat.contains("DD")) {
      newFormat = newFormat.replaceFirst(
          "DD", "${_local[language]!['short_days']![wkDay ?? weekDay()]}");
    }

    ///month name
    // 1
    if (newFormat.contains("mm")) {
      newFormat = newFormat.replaceFirst("mm", monthString);
    } else {
      newFormat = newFormat.replaceFirst("m", monthString);
    }

    // Muharram
    if (newFormat.contains("MMMM")) {
      newFormat =
          newFormat.replaceFirst("MMMM", _local[language]!['long']![month]!);
    } else {
      if (newFormat.contains("MM")) {
        newFormat =
            newFormat.replaceFirst("MM", _local[language]!['short']![month]!);
      }
    }

    ///year
    if (newFormat.contains("yyyy")) {
      newFormat = newFormat.replaceFirst("yyyy", yearString);
    } else {
      newFormat = newFormat.replaceFirst("yy", yearString.substring(2, 4));
    }
    return newFormat;
  }

  ///check past date
  bool isBefore(int year, int month, int day) {
    return hijriToGregorian(hYear, hMonth, hDay).millisecondsSinceEpoch <
        hijriToGregorian(year, month, day).millisecondsSinceEpoch;
  }

  ///check future date
  bool isAfter(int year, int month, int day) {
    return hijriToGregorian(hYear, hMonth, hDay).millisecondsSinceEpoch >
        hijriToGregorian(year, month, day).millisecondsSinceEpoch;
  }

  ///check same date
  bool isAtSameMomentAs(int year, int month, int day) {
    return hijriToGregorian(hYear, hMonth, hDay).millisecondsSinceEpoch ==
        hijriToGregorian(year, month, day).millisecondsSinceEpoch;
  }

  ///set adjustment value
  void setAdjustments(Map<int, int> adj) {
    adjustments = adj;
  }

  ///set index of ummalqura Data
  int? _ummalquraDataIndex(int index) {
    if (index < 0 || index >= ummAlquraDateArray.length) {
      throw ArgumentError(
          "Valid date should be between 1356 AH (14 March 1937 CE) to 1500 AH (16 November 2077 CE)");
    }
    if (adjustments != null && adjustments!.containsKey(index + 16260)) {
      return adjustments![index + 16260];
    }
    return ummAlquraDateArray[index];
  }

  ///get week day
  int weekDay() {
    DateTime wkDay = hijriToGregorian(hYear, hMonth, hDay);
    return wkDay.weekday;
  }

  ///convert date to string
  @override
  String toString() {
    String dateFormat = "dd/mm/yyyy";
    if (language == "rhg") dateFormat = "yyyy/mm/dd";

    return format(hYear, hMonth, hDay, dateFormat);
  }

  ///list of year, month & day
  List<int?> toList() => <int?>[hYear, hMonth, hDay];

  ///get full formatted date
  String fullDate() {
    return format(hYear, hMonth, hDay, "DDDD, MMMM dd, yyyy");
  }

  ///check date is valid or not
  bool isValid() {
    if (validateHijri(hYear, hMonth, hDay)) {
      if (hDay <= getDaysInMonth(hYear, hMonth)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  ///check hijri date is valid or not
  bool validateHijri(int year, int month, int day) {
    if (month < 1 || month > 12) {
      return false;
    }

    if (day < 1 || day > 30) {
      return false;
    }
    return true;
  }

  ///get full month name
  String getLongMonthName() {
    return _local[language]!['long']![hMonth]!;
  }

  ///get short month name
  String getShortMonthName() {
    return _local[language]!['short']![hMonth]!;
  }

  ///get day name
  String getDayName() {
    return _local[language]!['days']![wkDay!]!;
  }
}
