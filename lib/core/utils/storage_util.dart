import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await _preferences?.setString(key, value) ?? false;
  }

  static String? getString(String key) {
    return _preferences?.getString(key);
  }

  static Future<bool> remove(String key) async {
    return await _preferences?.remove(key) ?? false;
  }

  static Future<bool> clear() async {
    return await _preferences?.clear() ?? false;
  }

  static Future<bool> hasToken() async {
    final token = _preferences?.getString('access_token');
    return token != null && token.isNotEmpty;
  }
}