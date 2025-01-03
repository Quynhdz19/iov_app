import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/job_status.dart';

class SearchModal extends StatefulWidget {
  final void Function(Map<String, String>) onSearch;
  final String? initialVinNo;
  final String? initialFromDate;
  final String? initialToDate;
  final String? initialJobStatus;

  const SearchModal({
    Key? key,
    required this.onSearch,
    this.initialVinNo,
    this.initialFromDate,
    this.initialToDate,
    this.initialJobStatus,
  }) : super(key: key);

  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  late TextEditingController vinNoController;
  late TextEditingController fromDateController;
  late TextEditingController toDateController;
  String? selectedJobStatus;

  @override
  void initState() {
    super.initState();
    // Khởi tạo controller với giá trị ban đầu
    vinNoController = TextEditingController(text: widget.initialVinNo);
    fromDateController = TextEditingController(text: widget.initialFromDate);
    toDateController = TextEditingController(text: widget.initialToDate);
    selectedJobStatus = widget.initialJobStatus;
  }

  @override
  void dispose() {
    vinNoController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const jobStatusList = JobStatus.values;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // VIN Number
          TextField(
            controller: vinNoController,
            decoration: const InputDecoration(
              labelText: 'VIN Number',
              prefixIcon: Icon(Icons.directions_car),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          // Installation Date From
          TextField(
            controller: fromDateController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'From Date',
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  fromDateController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                });
              }
            },
          ),
          const SizedBox(height: 16),
          // Installation Date To
          TextField(
            controller: toDateController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'To Date',
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  toDateController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                });
              }
            },
          ),
          const SizedBox(height: 16),
          // Job Status
          DropdownButtonFormField<String>(
            value: selectedJobStatus,
            items: jobStatusList
                .map((status) => DropdownMenuItem<String>(
              value: status,
              child: Text(status),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedJobStatus = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Job Status',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          // Buttons
          Row(
            children: [
              // Clear Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                  ),
                  onPressed: () {
                    setState(() {
                      vinNoController.clear();
                      fromDateController.clear();
                      toDateController.clear();
                      selectedJobStatus = null;
                    });
                  },
                  child: const Text(
                    'Clear Conditions',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Search Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final searchCriteria = {
                      'search': vinNoController.text,
                      'from_date': fromDateController.text,
                      'to_date': toDateController.text,
                      'status': selectedJobStatus ?? '',
                    };
                    widget.onSearch(searchCriteria); // Truyền giá trị cho callback
                    Navigator.pop(context); // Đóng modal
                  },
                  child: const Text('Search'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}