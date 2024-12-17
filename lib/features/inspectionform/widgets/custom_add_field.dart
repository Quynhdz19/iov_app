import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAddField extends StatelessWidget {
  final String label;

  const CustomAddField({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.add),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
