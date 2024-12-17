import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/storage_util.dart';

class AuthService {
  static const String _baseUrl = "https://api.example.com";

  Future<bool> login(String username, String password) async {
    final url = Uri.parse("$_baseUrl/login");
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
      final token = data['token']; // Token từ API
      if (token != null) {
        await StorageUtil.setString('auth_token', token); // Lưu token vào Storage
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
}