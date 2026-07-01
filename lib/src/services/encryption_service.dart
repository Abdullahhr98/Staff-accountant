import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptionService {
  static final _storage = FlutterSecureStorage();
  static const _keyName = 'backup_key';

  static Future<void> _ensureKey() async {
    final k = await _storage.read(key: _keyName);
    if (k == null) {
      final key = Key.fromSecureRandom(32);
      await _storage.write(key: _keyName, value: key.base64);
    }
  }

  static Future<File> encryptFile(File input) async {
    await _ensureKey();
    final keyBase64 = await _storage.read(key: _keyName);
    final key = Key.fromBase64(keyBase64!);
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key));
    final bytes = await input.readAsBytes();
    final encrypted = encrypter.encryptBytes(bytes, iv: iv);
    final out = File('${input.path}.enc');
    await out.writeAsBytes(iv.bytes + encrypted.bytes);
    return out;
  }
}
