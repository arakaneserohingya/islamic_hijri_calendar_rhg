import 'package:flutter/material.dart';
import 'package:islamic_hijri_calendar_rhg/islamic_hijri_calendar_rhg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      themeMode: _themeMode,
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
  String _rohingyaFontFamily = 'Rohingya';

  @override
  Widget build(BuildContext context) {
    final themeMode = MyApp.of(context)._themeMode;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Islamic Hijri Calendar"),
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.dark
                ? Icons.light_mode
                : themeMode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.brightness_auto),
            onPressed: () {
              // Quick toggle or show dialog
              _showSettingsDialog(context);
            },
          ),
        ],
      ),
      body: IslamicHijriCalendar(
        isHijriView: true,
        adjustmentValue: _adjustmentValue,
        isGoogleFont: false,
        rohingyaFontFamily: _rohingyaFontFamily,
        getSelectedEnglishDate: (selectedDate) {},
        getSelectedHijriDate: (selectedDate) {},
        isDisablePreviousNextMonthDates: true,
        locale: _locale,
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int tempAdjustment = _adjustmentValue;
        String tempLocale = _locale;
        String tempRohingyaFont = _rohingyaFontFamily;
        ThemeMode tempThemeMode = MyApp.of(context)._themeMode;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("App Settings"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Hijri Date Adjustment",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: tempAdjustment.toDouble(),
                            min: -3,
                            max: 3,
                            divisions: 6,
                            onChanged: (double value) {
                              setState(() {
                                tempAdjustment = value.toInt();
                              });
                            },
                          ),
                        ),
                        Text(tempAdjustment.toString()),
                      ],
                    ),
                    const Divider(),
                    const Text("Language",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: tempLocale,
                      items: const [
                        DropdownMenuItem(value: 'rhg', child: Text("Rohingya")),
                        DropdownMenuItem(value: 'en', child: Text("English")),
                        DropdownMenuItem(value: 'ar', child: Text("Arabic")),
                      ],
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            tempLocale = value;
                          });
                        }
                      },
                    ),
                    const Divider(),
                    const Text("Rohingya Font",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: tempRohingyaFont,
                      items: const [
                        DropdownMenuItem(
                            value: 'Rohingya', child: Text("Rohingya")),
                        DropdownMenuItem(
                            value: 'NotoSansRohingya',
                            child: Text("Noto Sans Rohingya")),
                        DropdownMenuItem(value: 'Kuna', child: Text("Kuna")),
                        DropdownMenuItem(
                            value: 'KunaHara', child: Text("Kuna Hara")),
                        DropdownMenuItem(value: 'Omari', child: Text("Omari")),
                        DropdownMenuItem(
                            value: 'FoyaziKuna', child: Text("Foyazi Kuna")),
                        DropdownMenuItem(
                            value: 'KufiKuna', child: Text("Kufi Kuna")),
                        DropdownMenuItem(
                            value: 'QutubiKuna', child: Text("Qutubi Kuna")),
                      ],
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            tempRohingyaFont = value;
                          });
                        }
                      },
                    ),
                    const Divider(),
                    const Text("Theme Mode",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButton<ThemeMode>(
                      isExpanded: true,
                      value: tempThemeMode,
                      items: const [
                        DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text("System Default")),
                        DropdownMenuItem(
                            value: ThemeMode.light, child: Text("Light Mode")),
                        DropdownMenuItem(
                            value: ThemeMode.dark, child: Text("Dark Mode")),
                      ],
                      onChanged: (ThemeMode? value) {
                        if (value != null) {
                          setState(() {
                            tempThemeMode = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton(
                  child: const Text("Apply Details"),
                  onPressed: () {
                    // Update theme immediately via its own mechanism
                    MyApp.of(context).changeTheme(tempThemeMode);

                    // Update local state for other adjustments
                    this.setState(() {
                      _adjustmentValue = tempAdjustment;
                      _locale = tempLocale;
                      _rohingyaFontFamily = tempRohingyaFont;
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
  }
}
