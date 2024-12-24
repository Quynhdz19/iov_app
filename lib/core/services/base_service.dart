import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import '../utils/storage_util.dart';


class BaseService {
  static final String _baseUrl = dotenv.env['API_URL'] ?? '';

  Future<Map<String, String>> _getHeaders() async {
    final token = StorageUtil.getString('access_token');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _getHeaders();

    return await http.get(url, headers: headers);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _getHeaders();

    return await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _getHeaders();

    return await http.put(
      url,
      headers: headers,
      body: json.encode(data),
    );
  }

  Future<http.Response> patch(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _getHeaders();

    return await http.patch(
      url,
      headers: headers,
      body: json.encode(data),
    );
  }

  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _getHeaders();

    return await http.delete(url, headers: headers);
  }
}