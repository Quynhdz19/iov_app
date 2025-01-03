import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool notEditing;

  const CustomTextField({
    required this.label,
    required this.controller,
    required this.notEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120, // Chiều rộng cố định cho label
            child: Text(
              label,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(width: 8), // Khoảng cách giữa label và input
          Expanded(
            child: AbsorbPointer(
              absorbing: notEditing, // Ngăn thao tác khi notEditing là true
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Giữ nguyên border mặc định
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}