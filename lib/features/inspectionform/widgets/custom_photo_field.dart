import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomPhotoField extends StatefulWidget {
  final String label;
  final String? imageUrl; // URL từ API
  final Function(File?, bool) onImageChanged; // Callback để trả về File và trạng thái xóa

  const CustomPhotoField({
    Key? key,
    required this.label,
    this.imageUrl,
    required this.onImageChanged,
  }) : super(key: key);

  @override
  _CustomPhotoFieldState createState() => _CustomPhotoFieldState();
}

class _CustomPhotoFieldState extends State<CustomPhotoField> {
  File? _image; // Ảnh được chọn từ camera
  String? _imageUrl; // Quản lý URL nội bộ
  bool _isDeleted = false; // Cờ trạng thái xóa ảnh

  @override
  void initState() {
    super.initState();
    // Gán URL ảnh từ widget để quản lý nội bộ
    _imageUrl = widget.imageUrl;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Kiểm tra quyền camera và thư viện ảnh
    var cameraStatus = await Permission.camera.request();
    var storageStatus = await Permission.photos.request();

    if (cameraStatus.isGranted || storageStatus.isGranted) {
      try {
        final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);

        if (pickedImage != null) {
          setState(() {
            _image = File(pickedImage.path); // Lưu ảnh mới
            _imageUrl = null; // Clear URL nếu người dùng chọn ảnh mới
            _isDeleted = false; // Đặt cờ xóa thành false
          });

          widget.onImageChanged(_image, _isDeleted); // Gửi ảnh và trạng thái ra ngoài
        }
      } catch (e) {
        print("Lỗi khi mở máy ảnh: $e");
      }
    } else if (cameraStatus.isPermanentlyDenied || storageStatus.isPermanentlyDenied) {
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

  void _deleteImage() {
    setState(() {
      _image = null; // Xóa ảnh file
      _imageUrl = null; // Xóa URL ảnh
      _isDeleted = true; // Đặt cờ xóa
    });

    print("_isDeleted ${_isDeleted}");
    widget.onImageChanged(null, _isDeleted); // Gửi trạng thái xóa ra ngoài
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
            child: Column(
              children: [
                InkWell(
                  onTap: _pickImage, // Mở máy ảnh khi bấm vào ô input
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Thêm viền
                      borderRadius: BorderRadius.circular(8.0), // Bo góc
                    ),
                    child: _image != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                        : _imageUrl != null && _imageUrl!.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        _imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                        : Container(
                      height: 50, // Chiều cao cố định khi không có ảnh
                      child: const Center(
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                  ),
                ),
                if (_image != null || (_imageUrl != null && _imageUrl!.isNotEmpty))
                  TextButton(
                    onPressed: _deleteImage, // Xóa ảnh
                    child: const Text(
                      "Remove",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}