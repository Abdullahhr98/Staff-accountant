import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme = _lightTheme;

  static final ThemeData _lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
    useMaterial3: true,
  );

  static final ThemeData _darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
    useMaterial3: true,
  );

  void setLight() {
    currentTheme = _lightTheme;
    notifyListeners();
  }

  void setDark() {
    currentTheme = _darkTheme;
    notifyListeners();
  }

  void setAmoled() {
    currentTheme = ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black);
    notifyListeners();
  }

  void setCustom(Color primary) {
    currentTheme = ThemeData.from(colorScheme: ColorScheme.light(primary: primary));
    notifyListeners();
  }
}
