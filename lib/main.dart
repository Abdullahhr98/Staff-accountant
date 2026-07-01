import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'src/providers/auth_provider.dart';
import 'src/providers/employee_provider.dart';
import 'src/providers/settings_provider.dart';
import 'src/providers/theme_provider.dart';

// NOTE: Please run `flutterfire configure` locally or add your firebase_options.dart
// after configuring Firebase in the console.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    // If firebase_options.dart is missing, app can still run for UI testing; add Firebase config for full features.
    print('Firebase init error (may be missing firebase_options.dart): $e');
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ChangeNotifierProvider(create: (_) => EmployeeProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: MyApp(),
  ));
}
