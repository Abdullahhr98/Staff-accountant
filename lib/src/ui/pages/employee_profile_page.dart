import 'package:flutter/material.dart';
import '../../models/employee.dart';
import '../../models/transaction.dart';
import '../../utils/salary_calculator.dart';
import '../../services/pdf_service.dart';
import '../../services/whatsapp_service.dart';

class EmployeeProfilePage extends StatefulWidget {
  final Employee employee;
  EmployeeProfilePage(this.employee);

  @override
  State<EmployeeProfilePage> createState() => _EmployeeProfilePageState();
}

class _EmployeeProfilePageState extends State<EmployeeProfilePage> {
  @override
  Widget build(BuildContext context) {
    final e = widget.employee;
    return Scaffold(
      appBar: AppBar(
        title: Text(e.name),
        actions: [
          IconButton(icon: Icon(Icons.picture_as_pdf), onPressed: () => PdfService.generateEmployeePdf(e)),
          IconButton(icon: Icon(Icons.whatsapp), onPressed: () => WhatsAppService.shareEmployeeScreenshot(e)),
        ],
      ),
      body: Column(
        children: [
          ListTile(title: Text('Salary: ${e.salary} ${e.currency == Currency.USD ? 'USD' : 'SYP'}')),
        ],
      ),
    );
  }

  double calcDelay(double hoursDelayed) {
    final settingsHours = 8.0;
    final monthLength = SalaryCalculator.daysInMonth(DateTime.now());
    return SalaryCalculator.calculateDelay(
      hoursDelayed: hoursDelayed,
      dailyWorkingHours: settingsHours,
      monthlySalary: widget.employee.salary,
      monthLength: monthLength,
    );
  }
}
