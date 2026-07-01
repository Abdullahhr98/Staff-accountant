import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/employee_provider.dart';
import '../../ui/widgets/calendar_widget.dart';
import '../../ui/widgets/stats_card.dart';
import '../../models/employee.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final empProv = Provider.of<EmployeeProvider>(context);
    final employees = empProv.employees;

    final totalEmployees = employees.length;
    final totalSalaries = employees.fold<double>(0, (s, e) => s + e.salary);

    return Scaffold(
      appBar: AppBar(
        title: Text('Payroll Dashboard'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () => Navigator.pushNamed(context, '/employees')),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(children: [
              Expanded(child: StatsCard(title: 'Employees', value: '$totalEmployees')),
              SizedBox(width: 12),
              Expanded(child: StatsCard(title: 'Total Salaries', value: '$totalSalaries')),
            ]),
            SizedBox(height: 12),
            CalendarWidget(),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _shortcut(context, Icons.person_add, 'Add new employee', () => Navigator.pushNamed(context, '/employees')),
                _shortcut(context, Icons.insert_chart, 'Monthly report', () {}),
                _shortcut(context, Icons.backup, 'Backup & restore', () {}),
                _shortcut(context, Icons.settings, 'Settings', () => Navigator.pushNamed(context, '/settings')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _shortcut(BuildContext c, IconData icon, String label, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 160,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(c).cardColor),
          child: Column(
            children: [Icon(icon, size: 36), SizedBox(height: 8), Text(label, textAlign: TextAlign.center)],
          ),
        ),
      );
}
