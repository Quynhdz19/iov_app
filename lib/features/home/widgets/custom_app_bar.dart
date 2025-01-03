import 'package:flutter/material.dart';
import 'package:iov_app/features/home/widgets/search_modal.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(Map<String, dynamic>) onSearch; // Callback truyền dữ liệu tìm kiếm
  final VoidCallback onRefresh; // Callback khi nhấn refresh

  const CustomAppBar({
    Key? key,
    required this.onSearch,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Mở Drawer
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
          onPressed: () async {
            final criteria = await showModalBottomSheet<Map<String, dynamic>>(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => const SearchModal(), // Hiển thị modal tìm kiếm
            );

            if (criteria != null) {
              onSearch(criteria); // Truyền dữ liệu tìm kiếm ra ngoài
            }
          },
        ),
        // Refresh Icon
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.black),
          onPressed: onRefresh, // Gọi callback refresh
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}