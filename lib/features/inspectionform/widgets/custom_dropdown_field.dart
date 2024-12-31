import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;

  const CustomDropdownField({Key? key, required this.label, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          // Label bên trái
          SizedBox(
            width: 120, // Chiều rộng cố định cho label
            child: Text(
              label,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(width: 8), // Khoảng cách giữa label và ô chọn
          // Dropdown bên phải
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: items
                  .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
                  .toList(),
              onChanged: (value) {
                // Xử lý khi người dùng chọn
              },
            ),
          ),
        ],
      ),
    );
  }
}