import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iov_app/core/services/auth_service.dart';
import 'package:iov_app/core/utils/storage_util.dart'; // Để lưu token vào localStorage
import 'dart:convert'; // Để decode JSON Web Token (JWT)
import 'package:device_info_plus/device_info_plus.dart';

import '../../../core/utils/device_info_helper.dart'; // Để lấy thông tin thiết bị

class AuthViewModel with ChangeNotifier {

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _user; // State để lưu thông tin user

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get user => _user; // Getter cho thông tin user

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Lấy thông tin header từ thiết bị
      final headers = await DeviceInfoHelper().getDeviceHeaders();

      // Gọi login API với header
      final response = await _authService.loginWithHeaders(
        username: username,
        password: password,
        headers: headers,
      );

      if (response['code'] == 0) { //
        // Lưu token vào localStorage
        final accessToken = response['data']['access_token'];
        await StorageUtil.setString('access_token', accessToken);

        // Decode token để lấy thông tin user
        final payload = _decodeJWT(accessToken);
        _user = payload;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Xử lý lỗi
        _errorMessage = response['message'] ?? 'Login failed';
      }
    } catch (e) {
      _errorMessage = e.toString();
    }


    _isLoading = false;
    notifyListeners();
    return false;
  }



  // Hàm decode JWT
  Map<String, dynamic> _decodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return json.decode(payload);
  }

  // Hàm logout
  Future<void> logout() async {
    await StorageUtil.remove('access_token'); // Xóa token khỏi localStorage
    _user = null; // Xóa thông tin user khỏi state
    notifyListeners();
  }

  // Hàm kiểm tra token hết hạn
  Future<bool> isTokenExpired() async {
    final token = StorageUtil.getString('access_token');
    if (token == null) {
      return true; // Không có token
    }

    try {
      final payload = _decodeJWT(token);
      final exp = payload['exp'];
      if (exp == null) {
        return true; // Token không có hạn
      }

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiryDate); // Kiểm tra token hết hạn
    } catch (e) {
      return true; // Lỗi khi giải mã token
    }
  }

}