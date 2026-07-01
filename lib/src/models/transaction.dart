import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionType { deposit, withdrawal, bonus, delay, absence }

class EmployeeTransaction {
  String id;
  TransactionType type;
  double amount;
  String currency; // 'USD' or 'SYP'
  String note;
  Timestamp date;

  EmployeeTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.currency,
    this.note = '',
    Timestamp? date,
  }) : date = date ?? Timestamp.now();

  factory EmployeeTransaction.fromMap(String id, Map<String, dynamic> m) {
    return EmployeeTransaction(
      id: id,
      type: TransactionType.values.firstWhere((e) => e.toString() == m['type'], orElse: () => TransactionType.deposit),
      amount: (m['amount'] ?? 0.0).toDouble(),
      currency: m['currency'] ?? 'SYP',
      note: m['note'] ?? '',
      date: m['date'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'type': type.toString(),
        'amount': amount,
        'currency': currency,
        'note': note,
        'date': date,
      };
}
