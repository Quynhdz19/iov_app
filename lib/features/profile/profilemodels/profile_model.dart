import 'package:flutter/material.dart';

class ProfileModel with ChangeNotifier {
  String name = 'Lê Xuân Quỳnh';
  String realName = 'Quuynhlx';
  String nickname = 'abc';
  String position = 'Technician';
  String phoneNumber = '0657248593';
  String backupPhoneNumber = '0657248593';
  String email = 'jagavut@onelink.co.th';

  // Hàm cập nhật thông tin
  void updateDetails({
    required String name,
    required String realName,
    required String nickname,
    required String position,
    required String phoneNumber,
    required String backupPhoneNumber,
    required String email,
  }) {
    this.name = name;
    this.realName = realName;
    this.nickname = nickname;
    this.position = position;
    this.phoneNumber = phoneNumber;
    this.backupPhoneNumber = backupPhoneNumber;
    this.email = email;
    notifyListeners();
  }
}