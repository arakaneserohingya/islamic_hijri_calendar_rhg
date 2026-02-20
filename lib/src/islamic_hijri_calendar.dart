import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'hijri_calendar_config.dart';
import 'hijri_date.dart';
import 'hijri_view_model.dart';

import 'date_functions.dart';

/// A modern, customizable Islamic Hijri Calendar widget for Flutter.
///
/// This widget provides a complete calendar solution with:
/// * Multi-language support (English, Arabic, and Rohingya).
/// * Automatic display of major Islamic events.
/// * Dual-view for both Hijri and Gregorian dates.
/// * Support for Hanifi Rohingya script and numerals.
/// * Responsive layouts for mobile and tablet/desktop.
///
/// Example usage:
/// ```dart
/// IslamicHijriCalendar(
///   locale: 'en',
///   isHijriView: true,
///   highlightBorder: Colors.green,
///   getSelectedEnglishDate: (date) => print('Selected: $date'),
/// )
/// ```
class IslamicHijriCalendar extends StatefulWidget {
  /// Whether to display Hijri dates alongside Gregorian dates.
  ///
  /// Defaults to `true`.
  final bool? isHijriView;

  /// The border color for the currently selected date or today's date.
  ///
  /// If null, defaults to `Theme.of(context).colorScheme.primary`.
  final Color? highlightBorder;

  /// The border color for regular (non-selected) dates.
  ///
  /// If null, defaults to `Theme.of(context).dividerColor.withValues(alpha: 0.1)`.
  final Color? defaultBorder;

  /// The text color used for important dates like today's date.
  ///
  /// If null, defaults to `Theme.of(context).colorScheme.onPrimary`.
  final Color? highlightTextColor;

  /// The default text color for regular dates.
  ///
  /// If null, defaults to `Theme.of(context).colorScheme.onSurface`.
  final Color? defaultTextColor;

  /// The background color for the calendar grid cells.
  ///
  /// If null, defaults to `Theme.of(context).colorScheme.surface`.
  final Color? defaultBackColor;

  /// The adjustment value in days for the Hijri date.
  ///
  /// Some regions might require a ±1 or ±2 day adjustment based on
  /// local moon sightings. Positive values move the date forward,
  /// negative values move it backward.
  ///
  /// Defaults to `0`.
  final int adjustmentValue;

  /// Whether to use Google Fonts for typography.
  ///
  /// Set this to `true` if your [fontFamilyName] refers to a Google Font.
  /// Defaults to `false`.
  final bool? isGoogleFont;

  /// The font family name to be used for the calendar text.
  ///
  /// Can be a custom font defined in `pubspec.yaml` or a Google Font
  /// if [isGoogleFont] is set to `true`.
  final String? fontFamilyName;

  /// Callback function triggered when a date is selected.
  ///
  /// Returns the selected [DateTime] in Gregorian format.
  final Function(DateTime selectedDate)? getSelectedEnglishDate;

  /// Callback function triggered when a date is selected.
  ///
  /// Returns the selected [HijriDate] object.
  final Function(HijriDate selectedDate)? getSelectedHijriDate;

  /// Whether to disable interaction and visually fade dates that are not
  /// part of the current month being viewed.
  ///
  /// Defaults to `false`.
  final bool? isDisablePreviousNextMonthDates;

  /// The locale code for the calendar (e.g., 'en', 'ar', or 'rhg').
  ///
  /// This determines the translations, numeral systems, and text direction.
  final String locale;

  /// The font family name specifically for Rohingya text.
  ///
  /// If provided, this font will be used when [locale] is set to 'rhg'.
  /// This allows overriding the global [fontFamilyName] for Rohingya script.
  final String? rohingyaFontFamily;

  /// Creates a new [IslamicHijriCalendar].
  const IslamicHijriCalendar({
    super.key,
    this.isHijriView = true,
    this.highlightBorder,
    this.defaultBorder,
    this.highlightTextColor,
    this.defaultTextColor,
    this.defaultBackColor,
    this.adjustmentValue = 0,
    this.getSelectedHijriDate,
    this.getSelectedEnglishDate,
    this.fontFamilyName = "",
    this.isGoogleFont = false,
    this.isDisablePreviousNextMonthDates = true,
    required this.locale,
    this.rohingyaFontFamily,
  });

  @override
  State<IslamicHijriCalendar> createState() => _HijriCalendarWidgetsState();
}

class _HijriCalendarWidgetsState extends State<IslamicHijriCalendar> {
  HijriViewModel viewmodel = HijriViewModel();
  List<DateTime> days = <DateTime>[];

  Color get _resolvedHighlightBorder =>
      widget.highlightBorder ?? Theme.of(context).colorScheme.primary;
  Color get _resolvedDefaultBorder =>
      widget.defaultBorder ??
      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1);
  Color get _resolvedHighlightTextColor =>
      widget.highlightTextColor ?? Theme.of(context).colorScheme.onPrimary;
  Color get _resolvedDefaultTextColor =>
      widget.defaultTextColor ?? Theme.of(context).colorScheme.onSurface;
  Color get _resolvedDefaultBackColor =>
      widget.defaultBackColor ?? Theme.of(context).colorScheme.surface;

  @override
  void initState() {
    HijriCalendarConfig.setLocal(widget.locale);
    super.initState();
  }

  ///update calendar view when directly value change form user side without set state
  @override
  void didUpdateWidget(IslamicHijriCalendar oldWidget) {
    if (oldWidget.adjustmentValue != widget.adjustmentValue) {
      viewmodel.adjustmentValue = widget.adjustmentValue;
    }
    if (oldWidget.locale != widget.locale) {
      HijriCalendarConfig.setLocal(widget.locale);
    }
    super.didUpdateWidget(oldWidget);
  }

  String direction = 'None';

  ///on pan update event check direction
  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      direction = 'Right';
    } else if (details.delta.dx < 0) {
      direction = 'Left';
    } else if (details.delta.dy > 0) {
      direction = 'Down';
    } else if (details.delta.dy < 0) {
      direction = 'Up';
    }
  }

  ///on pan gesture update current month
  void _onPanEnd() {
    switch (direction) {
      case "None":
        break;
      case "Right":
        funcGetMonth(isPrevious: true);
        break;
      case "Left":
        funcGetMonth(isPrevious: false);
        break;
      case "Down":
        funcGetMonth(isPrevious: true);
        break;
      case "Up":
        funcGetMonth(isPrevious: false);
        break;
    }
  }

  ///click events of previous & next button
  void funcGetMonth({required bool isPrevious}) {
    isPrevious ? viewmodel.getPreviousMonth() : viewmodel.getNextMonth();
    setState(() {});
  }

  ///get total days in month with previous & next month days in first & last week
  List<DateTime> _getDaysInMonth(DateTime date) {
    days = <DateTime>[];

    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    int firstWeekday = firstDayOfMonth.weekday;
    int lastWeekday = lastDayOfMonth.weekday;

    // Add days from previous month
    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(firstDayOfMonth.subtract(Duration(days: i)));
    }

    // Add days of current month
    for (int i = 0; i < lastDayOfMonth.day; i++) {
      days.add(firstDayOfMonth.add(Duration(days: i)));
    }

    // Add days from next month
    for (int i = 1; i <= 7 - lastWeekday; i++) {
      days.add(lastDayOfMonth.add(Duration(days: i)));
    }
    return days;
  }

  ///set calendar grid view
  Widget funcCalendarDaysView(
      {required TextStyle textStyle,
      required double rowHeight,
      required double fontSize}) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) => _onPanUpdate(details),
      onPanEnd: (DragEndDetails details) => _onPanEnd(),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisExtent: rowHeight,
        ),
        itemCount: days.length,
        itemBuilder: (BuildContext context, int index) {
          ///single day block
          return viewmodel.buildDateBox(
              isHijriView: widget.isHijriView!,
              fontSize: fontSize,
              defaultTextColor: _resolvedDefaultTextColor,
              highlightTextColor: _resolvedHighlightTextColor,
              day: days[index],
              highlightBorder: _resolvedHighlightBorder,
              defaultBorder: _resolvedDefaultBorder,
              backgroundColor: _resolvedDefaultBackColor,
              deActiveDateBorderColor: _resolvedDefaultBorder,
              style: textStyle,
              onSelectedEnglishDate: (DateTime selectedDate) {
                if (widget.getSelectedEnglishDate != null) {
                  widget.getSelectedEnglishDate!(selectedDate);
                }
                setState(() {});
              },
              onSelectedHijriDate: (HijriDate selectedDate) {
                if (widget.getSelectedHijriDate != null) {
                  widget.getSelectedHijriDate!(selectedDate);
                }
              },
              isDisablePreviousNextMonthDates:
                  widget.isDisablePreviousNextMonthDates!,
              locale: widget.locale);
        },
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, TextStyle textStyle, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () => funcGetMonth(isPrevious: true),
            icon: Icon(Icons.chevron_left_rounded,
                size: 28, color: _resolvedHighlightBorder),
          ),
          GestureDetector(
            onTap: () async {
              final DateTime? pickedDate = await showDialog<DateTime>(
                context: context,
                builder: (BuildContext context) {
                  return Theme(
                    data: ThemeData(
                      useMaterial3: true,
                      colorScheme:
                          Theme.of(context).brightness == Brightness.dark
                              ? ColorScheme.dark(
                                  primary: _resolvedHighlightBorder,
                                  onPrimary: _resolvedHighlightTextColor,
                                  onSurface: _resolvedDefaultTextColor,
                                  surface: _resolvedDefaultBackColor,
                                )
                              : ColorScheme.light(
                                  primary: _resolvedHighlightBorder,
                                  onPrimary: _resolvedHighlightTextColor,
                                  onSurface: _resolvedDefaultTextColor,
                                  surface: _resolvedDefaultBackColor,
                                ),
                    ),
                    child: DatePickerDialog(
                      initialDate: viewmodel.currentDisplayMonthYear,
                      firstDate: DateTime(1900, 1, 1),
                      lastDate: DateTime(2050, 12, 31),
                    ),
                  );
                },
              );
              if (pickedDate != null && pickedDate != viewmodel.todayDate) {
                setState(() {
                  viewmodel.selectedDate = pickedDate;
                  viewmodel.currentDisplayMonthYear = pickedDate;
                });
              }
            },
            child: Column(
              children: <Widget>[
                Text(
                  // Localize Gregorian Year
                  "${DateFormat('MMMM').format(viewmodel.currentDisplayMonthYear)} ${DateFunctions.localizeNumber(viewmodel.currentDisplayMonthYear.year, widget.locale)}",
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize + 4,
                    color: _resolvedDefaultTextColor,
                  ),
                ),
                if (widget.isHijriView!) ...<Widget>[
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _resolvedHighlightBorder.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${viewmodel.getHijriMonthYear()} - ${DateFunctions.localizeNumber(HijriCalendarConfig.fromDate(viewmodel.currentDisplayMonthYear).hYear, widget.locale)}",
                      style: textStyle.copyWith(
                        fontSize: fontSize - 2,
                        fontWeight: FontWeight.w600,
                        color: _resolvedHighlightBorder,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: () => funcGetMonth(isPrevious: false),
            icon: Icon(Icons.chevron_right_rounded,
                size: 28, color: _resolvedHighlightBorder),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays(TextStyle textStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: List<Widget>.generate(7, (int index) {
          // viewmodel.headerOfDay is Mon(0)..Sun(6)
          // Config keys are 1=Mon..7=Sun.
          final int key = index + 1;
          final String dayName =
              HijriCalendarConfig.getShortDayNames(widget.locale)[key] ?? "";

          return Expanded(
            child: Center(
              child: Text(
                dayName.toUpperCase(),
                style: textStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _resolvedDefaultTextColor.withValues(alpha: 0.6),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEventsList(TextStyle textStyle, {bool isFlexible = true}) {
    final Widget eventsContainer = Container(
      decoration: BoxDecoration(
        color: _resolvedDefaultBackColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _resolvedHighlightBorder.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Title Header Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _resolvedHighlightBorder.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Text(
              HijriCalendarConfig.getLocalizedString(
                  widget.locale, 'events_title'),
              style: textStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _resolvedHighlightBorder,
                letterSpacing: 0.3,
              ),
            ),
          ),
          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: _resolvedHighlightBorder.withValues(alpha: 0.1),
          ),
          // Events List
          Expanded(
            child: Builder(
              builder: (BuildContext context) {
                // Collect events for the visible days
                final List<Map<String, String>> visibleEvents =
                    <Map<String, String>>[];
                for (DateTime date in days) {
                  final HijriCalendarConfig hijriDate = !viewmodel
                          .adjustmentValue.isNegative
                      ? HijriCalendarConfig.fromDate(
                          DateTime(date.year, date.month, date.day)
                              .add(Duration(days: viewmodel.adjustmentValue)))
                      : HijriCalendarConfig.fromDate(
                          DateTime(date.year, date.month, date.day).subtract(
                              Duration(days: viewmodel.adjustmentValue.abs())));

                  if (HijriCalendarConfig.islamicEvents[widget.locale]
                              ?[hijriDate.hMonth]
                          ?.containsKey(hijriDate.hDay) ??
                      false) {
                    final String dayStr;
                    if (widget.locale == 'rhg') {
                      dayStr = DateFunctions.convertEnglishToHijriNumber(
                          hijriDate.hDay);
                    } else if (widget.locale == 'ar') {
                      dayStr = hijriDate.toFormat("dd");
                    } else {
                      dayStr = hijriDate.hDay.toString();
                    }

                    visibleEvents.add(<String, String>{
                      'day': dayStr,
                      'month': hijriDate.getLongMonthName(),
                      'name': HijriCalendarConfig.islamicEvents[widget.locale]![
                          hijriDate.hMonth]![hijriDate.hDay]!,
                    });
                  }
                }

                if (visibleEvents.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.event_busy_rounded,
                            color: _resolvedDefaultTextColor.withValues(
                                alpha: 0.3),
                            size: 24),
                        const SizedBox(height: 4),
                        Text(
                          HijriCalendarConfig.getLocalizedString(
                              widget.locale, 'no_events'),
                          style: textStyle.copyWith(
                            color: _resolvedDefaultTextColor.withValues(
                                alpha: 0.5),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: visibleEvents.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (BuildContext context, int index) {
                    final Map<String, String> event = visibleEvents[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: _resolvedHighlightBorder.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              _resolvedHighlightBorder.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            // Date Box
                            Container(
                              width: 80,
                              height: 70,
                              decoration: BoxDecoration(
                                color: _resolvedHighlightBorder.withValues(
                                    alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      event['day']!,
                                      style: textStyle.copyWith(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: _resolvedHighlightBorder,
                                        height: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        event['month']!.toUpperCase(),
                                        style: textStyle.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: _resolvedHighlightBorder
                                              .withValues(alpha: 0.8),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Event Name
                            Expanded(
                              child: Text(
                                event['name']!,
                                style: textStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: _resolvedDefaultTextColor,
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );

    return Directionality(
      textDirection:
          widget.locale == 'en' ? TextDirection.ltr : TextDirection.rtl,
      child: isFlexible
          ? eventsContainer
          : SizedBox(height: 300, child: eventsContainer),
    );
  }

  @override
  Widget build(BuildContext context) {
    ///get total days in current month with previous(first week) & next months(last week) dates
    days = _getDaysInMonth(viewmodel.currentDisplayMonthYear);
    viewmodel.adjustmentValue = widget.adjustmentValue;

    TextStyle textStyle;
    String? effectiveFontFamily =
        (widget.locale == 'rhg' && widget.rohingyaFontFamily != null)
            ? widget.rohingyaFontFamily
            : widget.fontFamilyName;

    if (widget.isGoogleFont == true &&
        effectiveFontFamily != null &&
        effectiveFontFamily.isNotEmpty) {
      try {
        textStyle = GoogleFonts.getFont(effectiveFontFamily);
      } catch (e) {
        // Fallback if the specific Google Font is not found or fails to load
        textStyle = Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
      }
    } else {
      final TextStyle baseStyle =
          Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
      textStyle = (effectiveFontFamily == null || effectiveFontFamily.isEmpty)
          ? baseStyle
          : baseStyle.copyWith(
              fontFamily: effectiveFontFamily,
              package: 'islamic_hijri_calendar_rhg',
            );
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double parentWidth = constraints.maxWidth;
      final double parentHeight = constraints.maxHeight;

      ///minimum height of particular day box
      const double minRowHeight = 70;
      double fontSize = 16;
      final bool isWide = parentWidth > 600;

      if (parentWidth > 600) {
        fontSize = 18;
      } else if (parentWidth > 400) {
        fontSize = 16;
      } else {
        fontSize = 14;
      }

      final Widget calendarGrid = funcCalendarDaysView(
          textStyle: textStyle, rowHeight: minRowHeight, fontSize: fontSize);

      return Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _resolvedDefaultBackColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Calendar Section (Left)
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _buildHeader(context, textStyle, fontSize),
                            _buildWeekDays(textStyle),
                            const Divider(height: 1),
                            Expanded(
                                child:
                                    SingleChildScrollView(child: calendarGrid)),
                          ],
                        ),
                      ),
                      const VerticalDivider(width: 30, thickness: 1),
                      // Events Section (Right)
                      Expanded(
                        flex: 2,
                        // In Row layout, we almost always want flexible height if parent is constrained
                        // If parentHeight is internal scrollview infinite, we might need fallback?
                        // But Row in infinite height is weird. Assuming constrained mostly.
                        child: _buildEventsList(textStyle,
                            isFlexible: parentHeight != double.infinity),
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      _buildHeader(context, textStyle, fontSize),
                      _buildWeekDays(textStyle),
                      const Divider(height: 1),
                      calendarGrid,
                      const SizedBox(height: 10),
                      if (parentHeight != double.infinity)
                        Expanded(
                            child:
                                _buildEventsList(textStyle, isFlexible: true))
                      else
                        _buildEventsList(textStyle, isFlexible: false),
                    ],
                  ),
          ), // Container
        ),
      ); // Directionality
    }); // LayoutBuilder
  }
}
