import 'package:flutter/material.dart';
import 'package:islamic_hijri_calendar_rhg/islamic_hijri_calendar_rhg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Islamic Hijri Calendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const HijriCalendarExample(),
    );
  }
}

class HijriCalendarExample extends StatefulWidget {
  const HijriCalendarExample({
    super.key,
  });

  @override
  State<HijriCalendarExample> createState() => _HijriCalendarExampleState();
}

class _HijriCalendarExampleState extends State<HijriCalendarExample> {
  int _adjustmentValue = 0;
  String _locale = 'rhg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Islamic Hijri Calendar"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  int tempAdjustment = _adjustmentValue;
                  String tempLocale = _locale;

                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        title: const Text("Adjust Hijri Date"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Value: $tempAdjustment"),
                            Slider(
                              value: tempAdjustment.toDouble(),
                              min: -3,
                              max: 3,
                              divisions: 6,
                              label: tempAdjustment.toString(),
                              onChanged: (double value) {
                                setState(() {
                                  tempAdjustment = value.toInt();
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Language"),
                                DropdownButton<String>(
                                  value: tempLocale,
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'rhg',
                                      child: Text("Rohingya"),
                                    ),
                                    DropdownMenuItem(
                                      value: 'en',
                                      child: Text("English"),
                                    ),
                                    DropdownMenuItem(
                                      value: 'ar',
                                      child: Text("Arabic"),
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      setState(() {
                                        tempLocale = value;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: const Text("Save & Close"),
                            onPressed: () {
                              // Commit changes to main widget state
                              this.setState(() {
                                _adjustmentValue = tempAdjustment;
                                _locale = tempLocale;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: IslamicHijriCalendar(
        isHijriView:
            true, //allowing users to set either the English calendar only or display the Hijri calendar alongside the English calendar
        highlightBorder: Theme.of(context)
            .colorScheme
            .primary, // Set selected date border color
        defaultBorder: Theme.of(context)
            .colorScheme
            .onSurface
            .withValues(alpha: .1), // Set default date border color
        highlightTextColor:
            Theme.of(context).colorScheme.surface, // Set today date text color
        defaultTextColor: Theme.of(context)
            .colorScheme
            .onSurface, //Set others dates text color
        defaultBackColor: Theme.of(context)
            .colorScheme
            .surface, // Set default date background color
        adjustmentValue:
            _adjustmentValue, // Set hijri calendar adjustment value which is set  by user side
        isGoogleFont:
            true, // Set it true if you want to use google fonts else false
        fontFamilyName:
            "Noto Sans Rohingya", // Set your custom font family name or google font name
        getSelectedEnglishDate:
            (selectedDate) {}, // returns the date selected by user
        getSelectedHijriDate:
            (selectedDate) {}, // returns the date selected by user in Hijri format
        isDisablePreviousNextMonthDates:
            true, // Set dates which are not included in current month should show disabled or enabled
        locale: _locale,
      ),
    );
  }
}
