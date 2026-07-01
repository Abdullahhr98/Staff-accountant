import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  double workingHoursPerDay = 8.0;
  ThemeMode themeMode = ThemeMode.system;
  String defaultCurrency = 'SYP';

  Locale get locale => _locale;

  SettingsProvider() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('lang') ?? 'en';
    _locale = Locale(lang);
    workingHoursPerDay = prefs.getDouble('workingHours') ?? 8.0;
    defaultCurrency = prefs.getString('defaultCurrency') ?? 'SYP';
    notifyListeners();
  }

  Future<void> setLocale(Locale l) async {
    _locale = l;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', l.languageCode);
    notifyListeners();
  }

  Future<void> setWorkingHours(double hours) async {
    workingHoursPerDay = hours;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('workingHours', hours);
    notifyListeners();
  }
}
