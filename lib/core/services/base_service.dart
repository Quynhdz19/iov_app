import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/storage_util.dart';

class BaseService {
  static final String _baseUrl = dotenv.env['API_URL'] ?? '';

  Future<Map<String, String>> _getHeaders(BuildContext? context) async {
    final token = StorageUtil.getString('access_token');

    if (token != null) {
      final payload = _decodeJWT(token);
      final exp = payload['exp'];

      if (exp != null && DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(exp * 1000))) {
        // Token hết hạn
        _handleTokenExpired(context);
        throw Exception('Token expired');
      }
    }

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  void _handleTokenExpired(BuildContext? context) {
    // Xóa token khỏi bộ nhớ
    StorageUtil.remove('access_token');

    // Nếu có context, điều hướng về màn hình đăng nhập
    if (context != null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  Map<String, dynamic> _decodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return json.decode(payload);
  }

  Future<http.Response> get(String endpoint, {BuildContext? context}) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _getHeaders(context);

    return await http.get(url, headers: headers);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data, {BuildContext? context}) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _getHeaders(context);

    return await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data, {BuildContext? context}) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _getHeaders(context);

    return await http.put(
      url,
      headers: headers,
      body: json.encode(data),
    );
  }

  Future<http.Response> patch(String endpoint, Map<String, dynamic> data, {BuildContext? context}) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _getHeaders(context);

    return await http.patch(
      url,
      headers: headers,
      body: json.encode(data),
    );
  }

  Future<http.Response> delete(String endpoint, {BuildContext? context}) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _getHeaders(context);

    return await http.delete(url, headers: headers);
  }
}