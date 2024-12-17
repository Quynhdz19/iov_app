import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPhotoField extends StatelessWidget {
  final String label;

  const CustomPhotoField({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          IconButton(
            onPressed: () {
              // Action for Camera
            },
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}