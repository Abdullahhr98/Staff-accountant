import 'package:cloud_firestore/cloud_firestore.dart';

enum Currency { USD, SYP }

class Employee {
  String id;
  String name;
  String mobile;
  double salary; // monthly salary
  Currency currency;
  String notes;
  bool active;
  Timestamp createdAt;
  double balance;

  Employee({
    required this.id,
    required this.name,
    required this.mobile,
    required this.salary,
    required this.currency,
    this.notes = '',
    this.active = true,
    Timestamp? createdAt,
    this.balance = 0.0,
  }) : createdAt = createdAt ?? Timestamp.now();

  factory Employee.fromMap(String id, Map<String, dynamic> map) {
    return Employee(
      id: id,
      name: map['name'] ?? '',
      mobile: map['mobile'] ?? '',
      salary: (map['salary'] ?? 0).toDouble(),
      currency: (map['currency'] ?? 'SYP') == 'USD' ? Currency.USD : Currency.SYP,
      notes: map['notes'] ?? '',
      active: map['active'] ?? true,
      createdAt: map['createdAt'] ?? Timestamp.now(),
      balance: (map['balance'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'mobile': mobile,
        'salary': salary,
        'currency': currency == Currency.USD ? 'USD' : 'SYP',
        'notes': notes,
        'active': active,
        'createdAt': createdAt,
        'balance': balance,
      };
}
