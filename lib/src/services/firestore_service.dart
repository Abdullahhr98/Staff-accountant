import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/employee.dart';
import '../models/transaction.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String companyId;

  FirestoreService({required this.companyId});

  Future<void> addEmployee(Employee e) async {
    final ref = _db.collection('companies').doc(companyId).collection('employees').doc();
    e.id = ref.id;
    await ref.set(e.toMap());
  }

  Stream<List<Employee>> streamEmployees() {
    return _db
        .collection('companies')
        .doc(companyId)
        .collection('employees')
        .orderBy('name')
        .snapshots()
        .map((snap) => snap.docs.map((d) => Employee.fromMap(d.id, d.data())).toList());
  }

  Future<void> addTransaction(String employeeId, EmployeeTransaction txn) async {
    final ref = _db
        .collection('companies')
        .doc(companyId)
        .collection('employees')
        .doc(employeeId)
        .collection('transactions')
        .doc();
    txn.id = ref.id;
    await ref.set(txn.toMap());
    await _recalculateBalance(employeeId);
  }

  Stream<List<EmployeeTransaction>> streamTransactions(String employeeId) {
    return _db
        .collection('companies')
        .doc(companyId)
        .collection('employees')
        .doc(employeeId)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => EmployeeTransaction.fromMap(d.id, d.data())).toList());
  }

  Future<void> _recalculateBalance(String employeeId) async {
    final txnsRef = _db
        .collection('companies')
        .doc(companyId)
        .collection('employees')
        .doc(employeeId)
        .collection('transactions');
    final txns = await txnsRef.get();
    double balanceSYP = 0;
    double balanceUSD = 0;
    for (final d in txns.docs) {
      final m = d.data();
      final type = m['type'] as String;
      final amt = (m['amount'] ?? 0.0).toDouble();
      final currency = m['currency'] ?? 'SYP';
      final isIncome = type.contains('deposit') || type.contains('bonus');
      final sign = isIncome ? 1 : -1;
      if (currency == 'USD') balanceUSD += sign * amt;
      else balanceSYP += sign * amt;
    }
    final empRef = _db.collection('companies').doc(companyId).collection('employees').doc(employeeId);
    await empRef.update({'balance': balanceSYP, 'balanceUSD': balanceUSD});
  }
}
