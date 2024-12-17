import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset('assets/logo.png', height: 30), // Logo
          const SizedBox(width: 10),
          const Text('Inspections', style: TextStyle(fontSize: 20)),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Search action
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Notification action
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}