import 'package:flutter/material.dart';

class GroupHeader extends StatelessWidget {
  final String dateTime;
  final int itemCount;

  const GroupHeader({Key? key, required this.dateTime, required this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(dateTime, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('$itemCount', style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}