import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/local/app_localizations.dart';
import '../../drawer/drawer_menu.dart';
import '../screenmodels/kpi_model.dart';

class KpiJobScreen extends StatefulWidget {
  const KpiJobScreen({Key? key}) : super(key: key);

  @override
  _KpiJobScreenState createState() => _KpiJobScreenState();
}

class _KpiJobScreenState extends State<KpiJobScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<KpiModel>(context, listen: false).fetchJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final kpiModel = Provider.of<KpiModel>(context);

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
              kpiModel.fetchJobs();
            },
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: kpiModel.isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : kpiModel.errorMessage != null
            ? Center(
          child: Text(
            kpiModel.errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        )
            : kpiModel.kpiData.isEmpty
            ? Center(
          child: Text(
              AppLocalizations.of(context).translate('not_found_kpi'),
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).translate('overview'),
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildKpiCard(
                  icon: Icons.library_books,
                  label: AppLocalizations.of(context).translate('daily_kpi'),
                  actual: kpiModel.kpiData["daily"]?["actual"] ?? 0,
                  plan: kpiModel.kpiData["daily"]?["plan"] ?? 0,
                  color: Colors.blue.shade100,
                ),
                _buildKpiCard(
                  icon: Icons.stacked_bar_chart,
                  label: AppLocalizations.of(context).translate('monthly_kpi'),
                  actual: kpiModel.kpiData["monthly"]?["actual"] ?? 0,
                  plan: kpiModel.kpiData["monthly"]?["plan"] ?? 0,
                  color: Colors.green.shade100,
                ),
              ],
            ),
            const SizedBox(height: 24),
             Text(
              AppLocalizations.of(context).translate('KPI_details'),
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: (kpiModel.kpiData["last_3_months"] ?? [])
                    .length,
                itemBuilder: (context, index) {
                  final monthData =
                  kpiModel.kpiData["last_3_months"][index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        "${AppLocalizations.of(context).translate('Month')} ${monthData['month_no']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${AppLocalizations.of(context).translate('Plan')}: ${monthData['plan']} | ${AppLocalizations.of(context).translate('Reality')}: ${monthData['actual']}",
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
    required int actual,
    required int plan,
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
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "$actual / $plan",
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}