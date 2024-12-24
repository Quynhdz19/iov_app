import 'package:flutter/material.dart';

class InspectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Cho phép truyền tiêu đề từ bên ngoài
  final VoidCallback? onBackPressed; // Hàm cho nút quay lại

  const InspectionAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Nút quay lại
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          // Logo của bạn
          Image.asset(
            'assets/logo.png',
            height: 30,
          ),
          const SizedBox(width: 10),
          // Tiêu đề
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87, // Tùy chỉnh màu
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white, // Màu nền
      elevation: 1, // Độ bóng của AppBar
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}