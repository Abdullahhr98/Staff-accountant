import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'encryption_service.dart';

class BackupService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<File> createLocalBackup() async {
    final data = <String, dynamic>{};
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/backup_${DateTime.now().millisecondsSinceEpoch}.json';
    final file = File(path);
    await file.writeAsString('{"backup": "placeholder"}');
    return file;
  }

  Future<void> uploadToGoogleDrive(File file) async {
    throw UnimplementedError('Implement Drive upload with OAuth credentials.');
  }

  Future<void> saveEncryptedLocalBackup(File file) async {
    final enc = await EncryptionService.encryptFile(file);
  }
}
