import 'package:url_launcher/url_launcher.dart';
import '../models/employee.dart';

class WhatsAppService {
  static Future<void> shareEmployeeScreenshot(Employee e) async {
    final phone = e.mobile.replaceAll('+', '');
    final text = Uri.encodeComponent('Employee ${e.name} report');
    final url = Uri.parse('https://wa.me/$phone?text=$text');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }
}
