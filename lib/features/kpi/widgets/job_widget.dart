import 'package:flutter/material.dart';
import '../screenmodels/kpi_model.dart';

class JobCard extends StatelessWidget {
  final KpiModel job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Row(
          children: [
            Expanded(flex: 1, child: Text(job.jobNo)),
            Expanded(flex: 2, child: Text(job.jobName)),
            Expanded(flex: 1, child: Text(job.status)),
            Expanded(flex: 2, child: Text(job.assignedTo)),
            Expanded(flex: 1, child: Text(job.deadline)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Handle options
          },
        ),
      ),
    );
  }
}