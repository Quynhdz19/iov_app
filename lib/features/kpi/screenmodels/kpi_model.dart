import 'package:flutter/cupertino.dart';

class KpiModel with ChangeNotifier {
  String jobNo;
  String jobName;
  String status;
  String assignedTo;
  String deadline;

  // Constructor chính
  KpiModel({
    this.jobNo = '',
    this.jobName = '',
    this.status = '',
    this.assignedTo = '',
    this.deadline = '',
  });

  // Fake data
  List<KpiModel> fakeData() {
    return [
      KpiModel(
        jobNo: 'J001',
        jobName: 'Install Camera',
        status: 'Completed',
        assignedTo: 'John Doe',
        deadline: '2024-01-05',
      ),
      KpiModel(
        jobNo: 'J002',
        jobName: 'Fix GPS',
        status: 'Pending',
        assignedTo: 'Jane Smith',
        deadline: '2024-01-10',
      ),
      KpiModel(
        jobNo: 'J003',
        jobName: 'Update Software',
        status: 'In Progress',
        assignedTo: 'Tom Brown',
        deadline: '2024-01-15',
      ),
    ];
  }

  // Hàm để load dữ liệu giả
  void loadFakeData() {
    notifyListeners();
  }
}