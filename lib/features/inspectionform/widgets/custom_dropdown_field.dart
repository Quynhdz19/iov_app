import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;

  const CustomDropdownField({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: (value) {
          // Handle selection
        },
      ),
    );
  }
}
