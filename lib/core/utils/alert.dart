import 'package:flutter/material.dart';

class Alert {
  static void showOverlay({
    required BuildContext context,
    required String message,
    required Color color,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0, // Hiển thị ở trên cùng
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: color,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );

    // Thêm vào Overlay
    overlay?.insert(overlayEntry);

    // Xóa sau 3 giây
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  static Future<bool> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("OK"),
            ),
          ],
        );
      },
    ) ?? false;
  }
}