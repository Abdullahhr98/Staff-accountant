import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          ListTile(
            title: Text('Working hours per day'),
            subtitle: Text('${settings.workingHoursPerDay} h'),
            trailing: Icon(Icons.edit),
            onTap: () {},
          ),
          ListTile(
            title: Text('Language'),
            subtitle: Text(settings.locale.languageCode),
            onTap: () {
              settings.setLocale(settings.locale.languageCode == 'en' ? Locale('ar') : Locale('en'));
            },
          ),
          ListTile(
            title: Text('Themes'),
            subtitle: Text('Light / Dark / AMOLED / Custom'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Backup & Restore'),
            subtitle: Text('Google Drive / Local'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Security'),
            subtitle: Text('Email login, password reset, data encryption'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
