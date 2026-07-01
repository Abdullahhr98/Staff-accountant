import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 1).difference(DateTime(now.year, now.month, 1)).inDays;
    final remaining = daysInMonth - now.day;
    final progress = now.day / daysInMonth;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Text('${now.month}/${now.year}'),
                Spacer(),
                Text('$remaining days left'),
              ],
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(value: progress),
            SizedBox(height: 8),
            Text('Salary cycle progress ${(progress * 100).toStringAsFixed(0)}%')
          ],
        ),
      ),
    );
  }
}
