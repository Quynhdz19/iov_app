import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

class DeviceInfoHelper {
  Future<Map<String, String>> getDeviceHeaders() async {
    final deviceInfo = DeviceInfoPlugin();
    //final fcmToken = await FirebaseMessaging.instance.getToken(); // Lấy Device-Token từ Firebase

    //print(fcmToken);
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return {
        'Content-Type': 'application/json',
        'Device-Id': androidInfo.id ?? 'unknown_device_id',
        'Device-Name': androidInfo.model ?? 'unknown_device_name',
        'Device-Token': 'test_device_token_01',
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return {
        'Content-Type': 'application/json',
        'Device-Id': iosInfo.identifierForVendor ?? 'unknown_device_id',
        'Device-Name': iosInfo.utsname.machine ?? 'unknown_device_name',
        'Device-Token': 'test_device_token_01',
      };
    } else {
      return {
        'Content-Type': 'application/json',
        'Device-Id': 'unknown_device_id',
        'Device-Name': 'unknown_device_name',
        'Device-Token':  'unknown_device_token',
      };
    }
  }
}