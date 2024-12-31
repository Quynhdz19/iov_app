import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomPhotoField extends StatefulWidget {
  final String label;

  const CustomPhotoField({Key? key, required this.label}) : super(key: key);

  @override
  _CustomPhotoFieldState createState() => _CustomPhotoFieldState();
}

class _CustomPhotoFieldState extends State<CustomPhotoField> {
  XFile? _image; // File ảnh được chọn

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Kiểm tra quyền camera và thư viện ảnh
    var cameraStatus = await Permission.camera.request();
    var storageStatus = await Permission.photos.request();

    if (cameraStatus.isGranted || storageStatus.isGranted) {
      try {
        final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);

        if (pickedImage != null) {
          setState(() {
            _image = pickedImage; // Lưu ảnh đã chọn
          });
        }
      } catch (e) {
        print("Lỗi khi mở máy ảnh: $e");
      }
    } else if (cameraStatus.isPermanentlyDenied ||
        storageStatus.isPermanentlyDenied) {
      // Nếu quyền bị từ chối vĩnh viễn
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Quyền bị từ chối"),
          content: const Text(
              "Ứng dụng cần quyền truy cập camera và thư viện ảnh để hoạt động. Vui lòng cấp quyền trong phần Cài đặt."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); // Điều hướng người dùng đến Cài đặt
              },
              child: const Text("Đi tới Cài đặt"),
            ),
          ],
        ),
      );
    } else {
      print("Quyền camera hoặc lưu trữ bị từ chối tạm thời");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label bên trái
          SizedBox(
            width: 120, // Chiều rộng cố định cho label
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(width: 8), // Khoảng cách giữa label và ô input
          // Ô input hoặc ảnh
          Expanded(
            child: InkWell(
              onTap: _pickImage, // Mở máy ảnh khi bấm vào ô input
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Thêm viền
                  borderRadius: BorderRadius.circular(8.0), // Bo góc
                ),
                child: _image == null
                    ? Container(
                  height: 50, // Chiều cao cố định khi không có ảnh
                  child: const Center(
                    child: Icon(Icons.camera_alt),
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), // Bo góc ảnh
                  child: Image.file(
                    File(_image!.path),
                    fit: BoxFit.fitWidth, // Tự động căn chỉnh chiều cao
                    width: double.infinity, // Full chiều rộng ô input
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}