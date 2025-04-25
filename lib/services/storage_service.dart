import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const String _tokenKey = 'token';
  static const String _refreshTokenKey = 'refreshToken';

  final FlutterSecureStorage _storage;

  StorageService._internal(this._storage);

  factory StorageService() {
    return StorageService._internal(const FlutterSecureStorage());
  }

  Future<bool> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      return true;
    } catch (e) {
      print("⚠️ Lỗi lưu token: $e");
      return false;
    }
  }

  Future<String?> getToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      print("⚠️ Lỗi đọc token: $e");
      return null;
    }
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
      return true;
    } catch (e) {
      print("⚠️ Lỗi lưu refresh token: $e");
      return false;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: _refreshTokenKey);
    } catch (e) {
      print("⚠️ Lỗi đọc refresh token: $e");
      return null;
    }
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}