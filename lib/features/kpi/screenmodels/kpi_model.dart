import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../../core/services/base_service.dart';

class KpiModel with ChangeNotifier {
  final BaseService _baseService = BaseService();

  bool isLoading = false;
  String? errorMessage;
  Map<String, dynamic> kpiData = {};

  Future<void> fetchJobs() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    print("kpiData");
    try {
      final response = await _baseService.get('report/technician-kpi');

      final data = json.decode(response.body);
      if (data['code'] == 0) {
        kpiData = data['data'] ?? {};
        print("kpiData $kpiData");
      } else {
        errorMessage = data['message'] ?? 'Lỗi không xác định';
      }

    } catch (e) {
      errorMessage = 'Lỗi kết nối: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}