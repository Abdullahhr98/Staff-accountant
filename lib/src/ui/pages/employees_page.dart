import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/employee_provider.dart';
import '../widgets/employee_tile.dart';
import 'employee_profile_page.dart';

class EmployeesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final empProv = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Employees')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // open add employee dialog or page
        },
      ),
      body: ListView.builder(
        itemCount: empProv.employees.length,
        itemBuilder: (_, i) => EmployeeTile(
          employee: empProv.employees[i],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeProfilePage(empProv.employees[i]))),
        ),
      ),
    );
  }
}
