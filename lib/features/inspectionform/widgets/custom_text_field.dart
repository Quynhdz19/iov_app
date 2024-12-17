import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  const CustomTextField({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120, // Chiều rộng cố định của label
            child: Text(
              label,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(width: 8), // Khoảng cách giữa label và ô nhập
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
