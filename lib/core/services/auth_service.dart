import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/storage_util.dart';

class AuthService {
  static const String _baseUrl = "https://iov-installation-be.onrender.com/iov-app-api/v1";

  Future<bool> login(String username, String password) async {
    final url = Uri.parse("$_baseUrl/auth/login-mobile");
    final response = await http.post(
      url,
      body: json.encode({
        'username': username,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['access_token']; // Token từ API
      if (token != null) {
        await StorageUtil.setString('access_token', token); // Lưu token vào Storage
        return true;
      }
    }
    return false;
  }

  Future<void> logout() async {
    await StorageUtil.remove('auth_token'); // Xóa token khỏi Storage
  }

  Future<bool> isLoggedIn() async {
    final token = StorageUtil.getString('auth_token');
    return token != null;
  }

  Future<Map<String, dynamic>> loginWithHeaders({
    required String username,
    required String password,
    required Map<String, String> headers,
  }) async {
    final body = json.encode({
      'username': username,
      'password': password,
    });

    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login-mobile'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {
        'code': -1,
        'message': 'Login failed',
      };
    }
  }
}