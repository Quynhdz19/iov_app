import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

class DeviceInfoHelper {
  Future<Map<String, String>> getDeviceHeaders() async {
    final deviceInfo = DeviceInfoPlugin();
    String? deviceToken;

    try {
      deviceToken = await FirebaseMessaging.instance.getToken(); // Lấy Device-Token từ Firebase
    } catch (e) {
      deviceToken = 'unknown_device_token';
    }

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return {
          'Content-Type': 'application/json',
          'Device-Id': androidInfo.id ?? 'unknown_device_id',
          'Device-Name': androidInfo.model ?? 'unknown_device_name',
          'Device-Token': deviceToken ?? 'unknown_device_token',
        };
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return {
          'Content-Type': 'application/json',
          'Device-Id': iosInfo.identifierForVendor ?? 'unknown_device_id',
          'Device-Name': iosInfo.utsname.machine ?? 'unknown_device_name',
          'Device-Token': deviceToken ?? 'unknown_device_token',
        };
      } else {
        return {
          'Content-Type': 'application/json',
          'Device-Id': 'unknown_device_id',
          'Device-Name': 'unknown_device_name',
          'Device-Token': deviceToken ?? 'unknown_device_token',
        };
      }
    } catch (e) {
      print("Error retrieving device info: $e");
      return {
        'Content-Type': 'application/json',
        'Device-Id': 'unknown_device_id',
        'Device-Name': 'unknown_device_name',
        'Device-Token': deviceToken ?? 'unknown_device_token',
      };
    }
  }
}