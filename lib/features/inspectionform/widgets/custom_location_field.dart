import 'package:flutter/material.dart';

class CustomLocationField extends StatelessWidget {
  final String label;

  const CustomLocationField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          // Label với chiều rộng cố định
          SizedBox(
            width: 120, // Chiều rộng cố định của label
            child: Text(
              label,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(width: 8), // Khoảng cách giữa label và ô nhập
          // Ô nhập
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.location_on),
              ),
            ),
          ),
        ],
      ),
    );
  }
}