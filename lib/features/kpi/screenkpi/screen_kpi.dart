import 'package:flutter/material.dart';
import '../../drawer/drawer_menu.dart';
import '../screenmodels/kpi_model.dart';
import '../widgets/job_widget.dart';

class KpiJobScreen extends StatelessWidget {
  const KpiJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data cho công việc
    final List<KpiModel> jobs = [
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
      // Thêm dữ liệu khác nếu cần
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Xử lý làm mới
            },
          ),
        ],
      ),
      drawer: const DrawerMenu(userEmail: 'balloon28th@gmail.com'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Thanh tìm kiếm
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Job...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Xử lý tìm kiếm
              },
            ),
            const SizedBox(height: 16),
            // Header bảng
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Expanded(flex: 1, child: Text('Job No', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('Job Name', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('Assigned To', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('Deadline', style: TextStyle(fontWeight: FontWeight.bold))),
                  Icon(Icons.more_vert), // Biểu tượng thêm tùy chọn
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Danh sách công việc
            Expanded(
              child: ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return JobCard(job: jobs[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}