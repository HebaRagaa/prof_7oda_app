

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? _prefs;

  /// Secure storage (للـ tokens والحاجات الحساسة)
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// تهيئة SharedPreferences (لازم تتعمل في main)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ================== NORMAL STORAGE ==================

  /// حفظ String
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  /// قراءة String
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// حفظ bool
  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  /// قراءة bool
  static bool getBool(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  /// حفظ int
  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  /// قراءة int
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// حذف عنصر
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  /// مسح كل البيانات
  static Future<void> clear() async {
    await _prefs?.clear();
  }

  // ================== SECURE STORAGE ==================

  /// حفظ توكن
  static Future<void> setToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  /// قراءة توكن
  static Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  /// حذف توكن
  static Future<void> removeToken() async {
    await _secureStorage.delete(key: 'token');
  }

  /// مسح كل secure storage
  static Future<void> clearSecure() async {
    await _secureStorage.deleteAll();
  }
}


