import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:iov_app/core/utils/storage_util.dart';

class ProfileModel with ChangeNotifier {
  String? name;
  String? realName;
  String? nickname;
  String? position;
  String? phoneNumber;
  String? backupPhoneNumber;
  String? email;

  bool isLoading = false;

  Future<void> loadProfileFromToken() async {
    isLoading = true;
    notifyListeners(); // Thông báo trạng thái đang tải

    try {
      final token = await StorageUtil.getString('access_token');
      if (token != null) {
        final decodedToken = jsonDecode(
          utf8.decode(base64.decode(base64.normalize(token.split('.')[1]))),
        );
        name = decodedToken['user_name'];
        realName = decodedToken['full_name'];
        nickname = null; // Không có thông tin trong token
        position = decodedToken['role_name'];
        phoneNumber = decodedToken['phone_number'];
        backupPhoneNumber = null; // Không có thông tin trong token
        email = decodedToken['email'];
      }
    } catch (e) {
      debugPrint("Error decoding token: $e");
    } finally {
      isLoading = false;
      notifyListeners(); // Thông báo đã hoàn thành
    }
  }
}