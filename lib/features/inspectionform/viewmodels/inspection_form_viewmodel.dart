import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../../../core/services/base_service.dart';

class InspectionFormViewmodel with ChangeNotifier {
  final BaseService _baseService = BaseService();

  // Lưu trữ chi tiết job
  Map<String, dynamic>? jobDetails;

  // Lấy chi tiết job từ API
  Future<Map<String, dynamic>?> getDetailJob(int id) async {
    try {
      final response = await _baseService.get('job/$id');
      final data = json.decode(response.body);
      jobDetails = data['data'];
      return jobDetails;
    } catch (e) {
      debugPrint('Error fetching job details: $e');
    }
    return null;
  }

  // Cập nhật job
  Future<bool> updateJob(int id, Map<String, dynamic> updatedData) async {
    try {
      final response = await _baseService.putJob('job/update/$id', updatedData);
      final data = json.decode(response.body);

      print("$updatedData");
      if (data['code'] == 0) {
        jobDetails = {...?jobDetails, ...updatedData};
        notifyListeners();
        return true;
      } else {
        throw Exception(data['message']);
      }
    } catch (e) {

      debugPrint('Error updating job: $e');
      return false;
    }
  }

  Future<bool> doneJobs(int id) async {
    Map<String, dynamic> updatedData = {};
    try {
      final response = await _baseService.post('job/finish-installation/$id', updatedData);
      final data = json.decode(response.body);
      if (data['code'] == 0) {
        return true;
      }
    } catch (e) {
      debugPrint('Error done job : $e');
    }
    return false;
  }


}