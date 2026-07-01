import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../models/transaction.dart';
import '../services/firestore_service.dart';

class EmployeeProvider extends ChangeNotifier {
  final FirestoreService firestore = FirestoreService(companyId: 'default_company');

  List<Employee> employees = [];

  EmployeeProvider() {
    firestore.streamEmployees().listen((list) {
      employees = list;
      notifyListeners();
    });
  }

  Future<void> addEmployee(Employee e) async => await firestore.addEmployee(e);

  Stream<List<EmployeeTransaction>> transactionsStream(String employeeId) => firestore.streamTransactions(employeeId);

  Future<void> addTransaction(String employeeId, EmployeeTransaction txn) async =>
      await firestore.addTransaction(employeeId, txn);
}
