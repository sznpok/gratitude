import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();
const String keyAccess = "tokenAccess";

writeTokenAccess(data) async {
  return await _storage.write(key: keyAccess, value: data);
}

Future<String?> readTokenAccess() async {
  return await _storage.read(key: keyAccess);
}

deleteTokenAccess() async {
  return await _storage.delete(key: keyAccess);
}
