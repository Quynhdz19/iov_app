import 'package:flutter/material.dart';
import 'dart:convert'; // Để giải mã JWT
import '../core/utils/storage_util.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({Key? key, required this.child}) : super(key: key);

  Future<bool> _isTokenValid() async {
    final token = StorageUtil.getString('access_token');

    if (token == null) {
      return false; // Không có token
    }

    try {
      // Giải mã JWT
      final parts = token.split('.');
      if (parts.length != 3) {
        return false; // Token không hợp lệ
      }

      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      final exp = payload['exp'];
      if (exp == null) {
        return false; // Token không có hạn sử dụng
      }

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isBefore(expiryDate); // Kiểm tra token còn hợp lệ
    } catch (e) {
      return false; // Lỗi khi giải mã token
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isTokenValid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data == true) {
          // Token hợp lệ, cho phép truy cập
          return child;
        } else {
          // Token hết hạn hoặc không hợp lệ, điều hướng về Login
          Future.microtask(() => Navigator.pushReplacementNamed(context, '/'));
          return const SizedBox(); // Placeholder cho đến khi chuyển trang
        }
      },
    );
  }
}