import 'package:flutter/foundation.dart';
import '../../../core/services/base_service.dart';
import 'dart:convert';

class HomeViewModel with ChangeNotifier {
  final BaseService _baseService = BaseService();

  List<Map<String, dynamic>> _jobs = [];
  List<Map<String, dynamic>> get jobs => _jobs;

  List<Map<String, dynamic>> _groupedJobs = [];
  List<Map<String, dynamic>> get groupedJobs => _groupedJobs;

  bool _isLoading = false;
  bool _isFetchingMore = false;
  String? _errorMessage;

  int _currentPage = 1; // Trang hiện tại
  int _totalRecords = 0; // Tổng số bản ghi

  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;
  String? get errorMessage => _errorMessage;

  Future<void> fetchJobs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _baseService.get('job/search?page=$_currentPage');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 0) {
          _jobs = List<Map<String, dynamic>>.from(data['data']['jobs']);
          _totalRecords = data['data']['total_records'];
          _groupJobsByDate(); // Gọi hàm nhóm dữ liệu
        } else {
          _errorMessage = data['message'] ?? 'Failed to fetch jobs';
        }
      } else {
        _errorMessage = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreJobs() async {
    if (_isFetchingMore || _jobs.length >= _totalRecords) return;

    _isFetchingMore = true;
    _errorMessage = null;
    _currentPage++;
    notifyListeners();

    try {
      final response = await _baseService.get('job/search?page=$_currentPage');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 0) {
          _jobs.addAll(List<Map<String, dynamic>>.from(data['data']['jobs']));
          _groupJobsByDate(); // Gọi hàm nhóm dữ liệu
        } else {
          _errorMessage = data['message'] ?? 'Failed to fetch more jobs';
        }
      } else {
        _errorMessage = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Error occurred: $e';
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }

  Future<void> fetchJobsWithCriteria(Map<String, String> criteria) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();


    final vinNo = criteria['search'] ?? '';
    final fromDate = criteria['from_date'] ?? '';
    final toDate = criteria['to_date'] ?? '';
    final jobStatus = criteria['status'] ?? '';
    _currentPage = 1; // Reset về trang đầu tiên

    try {
      final response = await _baseService.get(
        'job/search?page=$_currentPage&search=$vinNo&from_date=$fromDate&to_date=$toDate&status=$jobStatus',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 0) {
          _jobs = List<Map<String, dynamic>>.from(data['data']['jobs']);
          _totalRecords = data['data']['total_records'];
          _groupJobsByDate(); // Gọi hàm nhóm dữ liệu
        } else {
          _errorMessage = data['message'] ?? 'Failed to fetch jobs with criteria';
        }
      } else {
        _errorMessage = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Hàm nhóm dữ liệu theo installation_date
  void _groupJobsByDate() {
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (final job in _jobs) {
      final date = job['installation_date'];
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(job);
    }

    // Chuyển dữ liệu thành dạng danh sách để dễ hiển thị
    _groupedJobs = grouped.entries
        .map((entry) => {'date': entry.key, 'items': entry.value})
        .toList();
  }
}