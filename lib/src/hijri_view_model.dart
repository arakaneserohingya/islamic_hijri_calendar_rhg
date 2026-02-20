import 'package:flutter/material.dart';
import 'date_functions.dart';
import 'hijri_calendar_config.dart';
import 'hijri_date.dart';

/// View model for the Hijri Calendar to manage state and logic.
class HijriViewModel {
  ///adjustment value for hijri calendar
  int adjustmentValue = 0;

  ///each day header value
  final List<String> headerOfDay = <String>[
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  ///each day show value
  final List<String> showOfDay = <String>[
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
  ];

  ///below date variables to manage highlight, disable, selected date ui
  DateTime currentDisplayMonthYear = DateTime.now();

  /// The currently selected date.
  DateTime selectedDate = DateTime.now();

  /// Today's date.
  DateTime todayDate = DateTime.now();

  /// This function is used to build each day block in the calendar grid.
  Widget buildDateBox({
    required bool isHijriView,
    required double fontSize,
    required DateTime day,
    required Color highlightBorder,
    Color? backgroundColor,
    required Color deActiveDateBorderColor,
    TextStyle? style,
    double? borderRadius,
    required Color defaultTextColor,
    required Color defaultBorder,
    required Color highlightTextColor,
    void Function(DateTime selectedDate)? onSelectedEnglishDate,
    void Function(HijriDate selectedDate)? onSelectedHijriDate,
    required bool isDisablePreviousNextMonthDates,
    required String locale,
  }) {
    bool isCurrentMonthDays = day.month == currentDisplayMonthYear.month;

    // Calculate Hijri Date
    final HijriCalendarConfig hijridate = !adjustmentValue.isNegative
        ? HijriCalendarConfig.fromDate(DateTime(day.year, day.month, day.day)
            .add(Duration(days: adjustmentValue)))
        : HijriCalendarConfig.fromDate(DateTime(day.year, day.month, day.day)
            .subtract(Duration(days: adjustmentValue.abs())));

    // Check conditions
    bool isToday = day.year == todayDate.year &&
        day.month == todayDate.month &&
        day.day == todayDate.day;

    bool isSelected = selectedDate.year == day.year &&
        selectedDate.month == day.month &&
        selectedDate.day == day.day;

    bool hasEvent = HijriCalendarConfig.islamicEvents[locale]?[hijridate.hMonth]
            ?.containsKey(hijridate.hDay) ??
        false;

    return GestureDetector(
      onTap: () {
        if (!isCurrentMonthDays) {
          currentDisplayMonthYear = day;
        }
        selectedDate = day;
        onSelectedEnglishDate!(DateTime(day.year, day.month, day.day));
        onSelectedHijriDate!(HijriDate(
            year: DateFunctions.convertEnglishToHijriNumber(hijridate.hYear),
            month: DateFunctions.convertEnglishToHijriNumber(hijridate.hMonth),
            day: DateFunctions.convertEnglishToHijriNumber(hijridate.hDay)));
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          // Background Color Logic
          color: isToday
              ? highlightBorder // Solid color for today
              : isSelected
                  ? highlightBorder.withValues(
                      alpha: 0.1) // Light highlight for selected
                  : Colors.transparent, // Default transparent

          // Shape/Border Logic
          borderRadius: BorderRadius.circular(12), // Rounded corners
          border: isSelected && !isToday
              ? Border.all(color: highlightBorder, width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // English Day Text
            Text(
              DateFunctions.localizeNumber(day.day, locale),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: style?.copyWith(
                    fontSize: fontSize,
                    fontWeight: (isToday || isSelected)
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isToday
                        ? highlightTextColor // White text on highlight color
                        : !isCurrentMonthDays
                            ? (isDisablePreviousNextMonthDates
                                ? defaultTextColor.withValues(alpha: 0.3)
                                : defaultTextColor)
                            : defaultTextColor,
                  ) ??
                  TextStyle(fontSize: fontSize),
            ),

            // Hijri Day Text (if view enabled)
            if (isHijriView) ...<Widget>[
              const SizedBox(height: 2),
              Text(
                DateFunctions.localizeNumber(hijridate.hDay, locale),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: style?.copyWith(
                      fontSize: fontSize - 4,
                      color: isToday
                          ? highlightTextColor.withValues(alpha: 0.9)
                          : !isCurrentMonthDays
                              ? (isDisablePreviousNextMonthDates
                                  ? defaultTextColor.withValues(alpha: 0.2)
                                  : defaultTextColor.withValues(alpha: 0.6))
                              : defaultTextColor.withValues(alpha: 0.6),
                    ) ??
                    TextStyle(fontSize: fontSize - 4),
              ),
            ],

            // Event Indicator Dot
            if (hasEvent) ...<Widget>[
              const SizedBox(height: 2),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: isToday ? highlightTextColor : highlightBorder,
                  shape: BoxShape.circle,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  /// Returns a formatted string for the current Hijri month and year.
  String getHijriMonthYear() {
    final int lastDayOfMonth = DateFunctions.getLastDayOfCurrentMonth(
            currentMonth: currentDisplayMonthYear)
        .day;
    String firstDateMonthName = HijriCalendarConfig.fromDate(DateTime(
            currentDisplayMonthYear.year, currentDisplayMonthYear.month, 1))
        .getLongMonthName();
    String lastDateMonthName = HijriCalendarConfig.fromDate(DateTime(
            currentDisplayMonthYear.year,
            currentDisplayMonthYear.month,
            lastDayOfMonth))
        .getLongMonthName();
    return firstDateMonthName == lastDateMonthName
        ? firstDateMonthName
        : "$firstDateMonthName / $lastDateMonthName";
  }

  ///show previous month
  void getPreviousMonth() {
    int year = currentDisplayMonthYear.year;
    int month = currentDisplayMonthYear.month - 1;

    if (month == 0) {
      month = 12;
      year--;
    }

    // Ensure the day is valid for the new month and year
    final int day = currentDisplayMonthYear.day;
    final int lastDayOfPreviousMonth = DateTime(year, month + 1, 0).day;
    final int finalDay =
        day > lastDayOfPreviousMonth ? lastDayOfPreviousMonth : day;

    currentDisplayMonthYear = DateTime(year, month, finalDay);
  }

  ///show next month
  void getNextMonth() {
    int year = currentDisplayMonthYear.year;
    int month = currentDisplayMonthYear.month + 1;

    if (month == 13) {
      month = 1;
      year++;
    }

    final int day = currentDisplayMonthYear.day;
    final int lastDayOfNextMonth = DateTime(year, month + 1, 0).day;
    final int finalDay = day > lastDayOfNextMonth ? lastDayOfNextMonth : day;

    currentDisplayMonthYear = DateTime(year, month, finalDay);
  }
}
