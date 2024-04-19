import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();
const String keyAccess = "tokenAccess";
const String keyUserName = "userName";
const String keyUserEmail = "userEmail";

writeTokenAccess(data) async {
  return await _storage.write(key: keyAccess, value: data);
}

Future<String?> readTokenAccess() async {
  return await _storage.read(key: keyAccess);
}

deleteTokenAccess() async {
  return await _storage.delete(key: keyAccess);
}

writeUserName(data) async {
  return await _storage.write(key: keyUserName, value: data);
}

Future<String?> readUserName() async {
  return await _storage.read(key: keyUserName);
}

writeUserEmail(data) async {
  return await _storage.write(key: keyUserEmail, value: data);
}

Future<String?> readUserEmail() async {
  return await _storage.read(key: keyUserEmail);
}
