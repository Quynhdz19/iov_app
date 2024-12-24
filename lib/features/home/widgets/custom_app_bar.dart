import 'package:flutter/material.dart';
import 'package:iov_app/features/home/widgets/search_modal.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(Map<String, String>) onSearch;

  const CustomAppBar({Key? key, required this.onSearch}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print(onSearch);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          // Mở Drawer
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Row(
        children: [
          // Logo
          Image.asset(
            'assets/logo.png',
            height: 30,
          ),
          const SizedBox(width: 10),
          // Title
          const Text(
            'Inspections',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        // Search Icon
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => SearchModal(onSearch: onSearch),
            );
          },
        ),
        // Refresh Icon with Badge
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: () {

              },
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: const Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}