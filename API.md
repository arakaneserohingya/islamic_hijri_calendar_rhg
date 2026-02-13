# API Documentation

Complete API reference for the Islamic Hijri Calendar (Rohingya Edition) Flutter package.

## Table of Contents

- [IslamicHijriCalendar Widget](#islamichijricalendar-widget)
- [Properties Reference](#properties-reference)
- [Callbacks](#callbacks)
- [Localization](#localization)
- [Advanced Usage](#advanced-usage)

---

## IslamicHijriCalendar Widget

The main widget that displays an Islamic Hijri calendar with multi-language support.

### Constructor

```dart
const IslamicHijriCalendar({
  Key? key,
  required String locale,
  bool? isHijriView = true,
  Color highlightBorder = Colors.blue,
  Color defaultBorder = const Color(0xfff2f2f2),
  Color highlightTextColor = Colors.white,
  Color defaultTextColor = Colors.black,
  Color defaultBackColor = Colors.white,
  int adjustmentValue = 0,
  bool? isGoogleFont = false,
  String? fontFamilyName = "",
  Function(DateTime selectedDate)? getSelectedEnglishDate,
  Function(HijriDate selectedDate)? getSelectedHijriDate,
  bool? isDisablePreviousNextMonthDates = true,
})
```

---

## Properties Reference

### Required Properties

#### `locale` (String)

**Required.** The language code for localization.

- **Type:** `String`
- **Values:** `'en'` (English), `'ar'` (Arabic), `'rhg'` (Rohingya)
- **Default:** None (must be specified)

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en', // English
)
```

---

### Display Properties

#### `isHijriView` (bool?)

Controls whether to display Hijri dates alongside Gregorian dates.

- **Type:** `bool?`
- **Default:** `true`
- **When `true`:** Shows both Gregorian and Hijri dates
- **When `false`:** Shows only Gregorian dates

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  isHijriView: true, // Show Hijri dates
)
```

---

### Color Properties

#### `highlightBorder` (Color)

Border color for today's date and selected dates.

- **Type:** `Color`
- **Default:** `Colors.blue`

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  highlightBorder: Theme.of(context).colorScheme.primary,
)
```

#### `defaultBorder` (Color)

Border color for regular dates.

- **Type:** `Color`
- **Default:** `Color(0xfff2f2f2)`

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  defaultBorder: Colors.grey.shade200,
)
```

#### `highlightTextColor` (Color)

Text color for today's date.

- **Type:** `Color`
- **Default:** `Colors.white`

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  highlightTextColor: Colors.white,
)
```

#### `defaultTextColor` (Color)

Text color for regular dates.

- **Type:** `Color`
- **Default:** `Colors.black`

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  defaultTextColor: Theme.of(context).colorScheme.onSurface,
)
```

#### `defaultBackColor` (Color)

Background color for the calendar.

- **Type:** `Color`
- **Default:** `Colors.white`

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  defaultBackColor: Theme.of(context).colorScheme.surface,
)
```

---

### Calendar Adjustment

#### `adjustmentValue` (int)

Adjusts the Hijri date by a specified number of days. Useful for regional variations in moon sighting.

- **Type:** `int`
- **Range:** `-3` to `+3`
- **Default:** `0`

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  adjustmentValue: 1, // Add 1 day to Hijri dates
)
```

---

### Font Properties

#### `isGoogleFont` (bool?)

Determines whether to use Google Fonts.

- **Type:** `bool?`
- **Default:** `false`

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'rhg',
  isGoogleFont: true,
  fontFamilyName: 'Noto Sans Rohingya',
)
```

#### `fontFamilyName` (String?)

The font family name to use (custom font or Google Font).

- **Type:** `String?`
- **Default:** `""`

**For Rohingya (recommended):**
```dart
IslamicHijriCalendar(
  locale: 'rhg',
  isGoogleFont: true,
  fontFamilyName: 'Noto Sans Rohingya',
)
```

**For custom fonts:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  isGoogleFont: false,
  fontFamilyName: 'MyCustomFont', // Must be defined in pubspec.yaml
)
```

---

### Behavior Properties

#### `isDisablePreviousNextMonthDates` (bool?)

Controls whether dates from previous/next months are disabled.

- **Type:** `bool?`
- **Default:** `true`
- **When `true`:** Previous/next month dates are grayed out and non-clickable
- **When `false`:** All dates are clickable

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  isDisablePreviousNextMonthDates: true,
)
```

---

## Callbacks

### `getSelectedEnglishDate` (Function?)

Called when a user selects a date, returning the Gregorian date.

- **Type:** `Function(DateTime selectedDate)?`
- **Parameter:** `DateTime selectedDate` - The selected Gregorian date

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  getSelectedEnglishDate: (selectedDate) {
    print('Selected: ${selectedDate.toString()}');
    // Do something with the selected date
  },
)
```

### `getSelectedHijriDate` (Function?)

Called when a user selects a date, returning the Hijri date.

- **Type:** `Function(HijriDate selectedDate)?`
- **Parameter:** `HijriDate selectedDate` - The selected Hijri date

**Example:**
```dart
IslamicHijriCalendar(
  locale: 'en',
  getSelectedHijriDate: (selectedDate) {
    print('Hijri: ${selectedDate.hDay}/${selectedDate.hMonth}/${selectedDate.hYear}');
    // Do something with the Hijri date
  },
)
```

---

## Localization

### Supported Languages

| Language | Code | Script | Numerals |
|----------|------|--------|----------|
| English | `en` | Latin | 0-9 |
| Arabic | `ar` | Arabic | ٠-٩ |
| Rohingya | `rhg` | Hanifi | 𐴰-𐴹 |

### Language-Specific Features

#### English (`en`)

- Left-to-right (LTR) layout
- Western numerals (0-9)
- Latin month names

```dart
IslamicHijriCalendar(
  locale: 'en',
  isGoogleFont: false,
)
```

#### Arabic (`ar`)

- Right-to-left (RTL) layout
- Arabic-Indic numerals (٠-٩)
- Arabic month names

```dart
IslamicHijriCalendar(
  locale: 'ar',
  isGoogleFont: true,
  fontFamilyName: 'Cairo', // or any Arabic font
)
```

#### Rohingya (`rhg`)

- Right-to-left (RTL) layout
- Hanifi numerals (𐴰-𐴹)
- Rohingya Hanifi month names

```dart
IslamicHijriCalendar(
  locale: 'rhg',
  isGoogleFont: true,
  fontFamilyName: 'Noto Sans Rohingya',
)
```

---

## Advanced Usage

### Theme Integration

Integrate seamlessly with your app's theme:

```dart
IslamicHijriCalendar(
  locale: 'en',
  highlightBorder: Theme.of(context).colorScheme.primary,
  defaultBorder: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
  highlightTextColor: Theme.of(context).colorScheme.onPrimary,
  defaultTextColor: Theme.of(context).colorScheme.onSurface,
  defaultBackColor: Theme.of(context).colorScheme.surface,
)
```

### Dark Mode Support

```dart
IslamicHijriCalendar(
  locale: 'en',
  highlightBorder: Theme.of(context).brightness == Brightness.dark
      ? Colors.tealAccent
      : Colors.teal,
  defaultTextColor: Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : Colors.black,
  defaultBackColor: Theme.of(context).brightness == Brightness.dark
      ? Colors.grey.shade900
      : Colors.white,
)
```

### Language Switcher

```dart
class MyCalendarWidget extends StatefulWidget {
  @override
  _MyCalendarWidgetState createState() => _MyCalendarWidgetState();
}

class _MyCalendarWidgetState extends State<MyCalendarWidget> {
  String _currentLocale = 'en';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: _currentLocale,
          items: const [
            DropdownMenuItem(value: 'en', child: Text('English')),
            DropdownMenuItem(value: 'ar', child: Text('العربية')),
            DropdownMenuItem(value: 'rhg', child: Text('𐴌𐴟𐴇𐴥𐴝𐴕𐴔𐴝')),
          ],
          onChanged: (value) {
            setState(() {
              _currentLocale = value!;
            });
          },
        ),
        Expanded(
          child: IslamicHijriCalendar(
            locale: _currentLocale,
            isHijriView: true,
          ),
        ),
      ],
    );
  }
}
```

### Date Adjustment Settings

```dart
class CalendarWithSettings extends StatefulWidget {
  @override
  _CalendarWithSettingsState createState() => _CalendarWithSettingsState();
}

class _CalendarWithSettingsState extends State<CalendarWithSettings> {
  int _adjustment = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Hijri Adjustment: $_adjustment days'),
        Slider(
          value: _adjustment.toDouble(),
          min: -3,
          max: 3,
          divisions: 6,
          label: _adjustment.toString(),
          onChanged: (value) {
            setState(() {
              _adjustment = value.toInt();
            });
          },
        ),
        Expanded(
          child: IslamicHijriCalendar(
            locale: 'en',
            adjustmentValue: _adjustment,
          ),
        ),
      ],
    );
  }
}
```

### Responsive Design

The calendar automatically adapts to screen size:

- **Mobile (< 600px):** Column layout with calendar above events
- **Tablet/Desktop (≥ 600px):** Row layout with calendar and events side-by-side

```dart
// No special configuration needed - it's automatic!
IslamicHijriCalendar(
  locale: 'en',
  isHijriView: true,
)
```

---

## Islamic Events

The calendar automatically displays these Islamic events when they occur in the visible month:

| Event | Hijri Date | English Name |
|-------|-----------|--------------|
| Islamic New Year | Muharram 1 | Ras as-Sanah al-Hijriyah |
| Ashura | Muharram 10 | Day of Ashura |
| Mawlid al-Nabi | Rabi' al-Awwal 12 | Prophet's Birthday |
| Isra and Mi'raj | Rajab 27 | Night Journey |
| Mid-Sha'ban | Sha'ban 15 | Laylat al-Bara'ah |
| First of Ramadan | Ramadan 1 | Start of Ramadan |
| Laylat al-Qadr | Ramadan 27 | Night of Power |
| Eid al-Fitr | Shawwal 1 | Festival of Breaking Fast |
| Day of Arafah | Dhul Hijjah 9 | Day of Arafah |
| Eid al-Adha | Dhul Hijjah 10 | Festival of Sacrifice |

Events are automatically localized based on the `locale` parameter.

---

## HijriDate Class

The `HijriDate` object returned by `getSelectedHijriDate` callback has the following properties:

```dart
class HijriDate {
  int hDay;    // Hijri day (1-30)
  int hMonth;  // Hijri month (1-12)
  int hYear;   // Hijri year
  
  String getLongMonthName();  // Get full month name
  String toFormat(String format);  // Format the date
}
```

**Example:**
```dart
getSelectedHijriDate: (hijriDate) {
  print('Day: ${hijriDate.hDay}');
  print('Month: ${hijriDate.hMonth}');
  print('Year: ${hijriDate.hYear}');
  print('Month Name: ${hijriDate.getLongMonthName()}');
}
```

---

## Best Practices

### 1. Font Selection

For Rohingya language, always use a Hanifi-compatible font:

```dart
IslamicHijriCalendar(
  locale: 'rhg',
  isGoogleFont: true,
  fontFamilyName: 'Noto Sans Rohingya',
)
```

### 2. Theme Consistency

Use theme colors for consistent appearance:

```dart
highlightBorder: Theme.of(context).colorScheme.primary,
defaultTextColor: Theme.of(context).colorScheme.onSurface,
```

### 3. Date Adjustment

Allow users to adjust Hijri dates for regional variations:

```dart
// Provide a settings UI for users to adjust
adjustmentValue: userPreferredAdjustment, // -3 to +3
```

### 4. Responsive Layouts

The calendar handles responsiveness automatically, but ensure your parent container provides adequate space:

```dart
// Good
Expanded(
  child: IslamicHijriCalendar(locale: 'en'),
)

// Also good
SizedBox(
  height: 600,
  child: IslamicHijriCalendar(locale: 'en'),
)
```

---

## Troubleshooting

### Issue: Rohingya text not displaying correctly

**Solution:** Ensure you're using a Hanifi-compatible font like "Noto Sans Rohingya":

```dart
IslamicHijriCalendar(
  locale: 'rhg',
  isGoogleFont: true,
  fontFamilyName: 'Noto Sans Rohingya',
)
```

### Issue: Calendar not updating when locale changes

**Solution:** Ensure you're calling `setState()` when changing the locale:

```dart
setState(() {
  _currentLocale = newLocale;
});
```

### Issue: Events not showing

**Solution:** Events only show for the current visible month. Navigate to months with Islamic events (e.g., Ramadan, Dhul Hijjah).

---

## See Also

- [README.md](README.md) - Package overview and quick start
- [CHANGELOG.md](CHANGELOG.md) - Version history
- [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute
- [Example App](example/) - Full working example
