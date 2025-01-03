import 'package:flutter/material.dart';

import '../../drawer/drawer_menu.dart';

class KpiJobScreen extends StatelessWidget {
  const KpiJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dữ liệu KPI mẫu
    final Map<String, dynamic> kpiData = {
      "daily": {"actual": 0, "plan": 10},
      "last_3_months": [
        {"actual": 0, "month_no": 10, "plan": 0},
        {"actual": 0, "month_no": 11, "plan": 0},
        {"actual": 0, "month_no": 12, "plan": 0},
      ],
      "monthly": {"actual": 0, "plan": 10},
    };

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tổng quan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // KPI Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildKpiCard(
                  icon: Icons.library_books,
                  label: "daily",
                  value: "6",
                  color: Colors.blue.shade100,
                ),
                _buildKpiCard(
                  icon: Icons.school,
                  label: "monthly",
                  value: "3",
                  color: Colors.green.shade100,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Chi tiết KPI',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: kpiData["last_3_months"].length,
                itemBuilder: (context, index) {
                  final monthData = kpiData["last_3_months"][index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        "Tháng ${monthData['month_no']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Kế hoạch: ${monthData['plan']} | Thực tế: ${monthData['actual']}",
                      ),
                      leading: Icon(
                        Icons.bar_chart,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.blue.shade700),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}