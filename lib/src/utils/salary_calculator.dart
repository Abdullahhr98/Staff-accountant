import 'package:intl/intl.dart';

class SalaryCalculator {
  static double calculateDelay({
    required double hoursDelayed,
    required double dailyWorkingHours,
    required double monthlySalary,
    required int monthLength,
  }) {
    if (hoursDelayed <= 0) return 0.0;
    final dailyWage = monthlySalary / 30.0;
    final penalty = (hoursDelayed / dailyWorkingHours) * dailyWage;
    return _round(penalty);
  }

  static double calculateAbsence({
    required int daysAbsent,
    required double monthlySalary,
    required int monthLength,
  }) {
    if (daysAbsent <= 0) return 0.0;
    double modifier = 1.0;
    if (monthLength == 31) modifier = (30.0 + 1.0) / 30.0;
    if (monthLength == 28) modifier = (30.0 - 2.0) / 30.0;
    final effectiveDaily = monthlySalary / 30.0 * modifier;
    final penalty = effectiveDaily * daysAbsent;
    return _round(penalty);
  }

  static int daysInMonth(DateTime date) {
    final firstDayThisMonth = DateTime(date.year, date.month, 1);
    final firstDayNextMonth = DateTime(date.year, date.month + 1, 1);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  static double _round(double value) => double.parse(value.toStringAsFixed(2));
}
