import 'package:flutter/material.dart';
import '../core/utils/storage_util.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: StorageUtil.hasToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data == true) {
          // Token tồn tại, cho phép truy cập
          return child;
        } else {
          // Token không tồn tại, điều hướng về Login
          Future.microtask(() => Navigator.pushReplacementNamed(context, '/'));
          return const SizedBox(); // Placeholder cho đến khi chuyển trang
        }
      },
    );
  }
}