import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();
  final String keyAccess = "tokenAccess";

  writeTokenAccess(data) async {
    await _storage.write(key: keyAccess, value: data);
  }

  readTokenAccess() async {
    await _storage.read(key: keyAccess);
  }

  deleteTokenAccess() async {
    await _storage.delete(key: keyAccess);
  }
}
