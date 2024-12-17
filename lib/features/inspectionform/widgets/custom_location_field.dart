import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLocationField extends StatelessWidget {
  final String label;

  const CustomLocationField({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.location_on),
        ),
      ),
    );
  }
}