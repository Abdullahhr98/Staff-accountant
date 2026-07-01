import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/ui/pages/home_page.dart';
import 'src/ui/pages/employees_page.dart';
import 'src/ui/pages/settings_page.dart';
import 'src/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'src/utils/localizations.dart';
import 'src/providers/theme_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Payroll Accountant',
      debugShowCheckedModeBanner: false,
      theme: theme.currentTheme,
      locale: settings.locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        // AppLocalizations.delegate, // implement localization delegate as needed
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: {
        '/': (_) => HomePage(),
        '/employees': (_) => EmployeesPage(),
        '/settings': (_) => SettingsPage(),
      },
    );
  }
}
