import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/employee.dart';

class PdfService {
  static Future<void> generateEmployeePdf(Employee e) async {
    final doc = pw.Document();
    doc.addPage(pw.Page(build: (pw.Context ctx) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Employee Report', style: pw.TextStyle(fontSize: 24)),
          pw.SizedBox(height: 12),
          pw.Text('Name: ${e.name}'),
          pw.Text('Mobile: ${e.mobile}'),
          pw.Text('Salary: ${e.salary}'),
        ],
      );
    }));

    await Printing.sharePdf(bytes: await doc.save(), filename: '${e.name}_report.pdf');
  }
}
