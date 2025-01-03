import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iov_app/features/home/widgets/searchStatusInput.dart';
import '../../../core/local/app_localizations.dart';
import '../constants/job_status.dart';

class SearchModal extends StatefulWidget {
  const SearchModal({Key? key}) : super(key: key);

  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  late TextEditingController vinNoController;
  late TextEditingController fromDateController;
  late TextEditingController toDateController;
  List<String> selectedStatusJobs = [];
  String? toDateError;

  @override
  void initState() {
    super.initState();
    _loadSavedState();
  }

  @override
  void dispose() {
    vinNoController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      vinNoController = TextEditingController(text: prefs.getString('vinNo') ?? '');
      fromDateController = TextEditingController(text: prefs.getString('fromDate') ?? '');
      toDateController = TextEditingController(text: prefs.getString('toDate') ?? '');
      selectedStatusJobs = prefs.getStringList('selectedStatusJobs') ?? [];
    });
  }


  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('vinNo', vinNoController.text);
    prefs.setString('fromDate', fromDateController.text);
    prefs.setString('toDate', toDateController.text);
    prefs.setStringList('selectedStatusJobs', selectedStatusJobs);
  }

  Future<void> conditions() async {
    if (!_validateDates()) {
      // Nếu ngày không hợp lệ, dừng lại
      return;
    }
    await _saveState();
    final Map<String, dynamic> formData = {
      'search': vinNoController.text,
      'from_date': fromDateController.text,
      'to_date': toDateController.text,
      'status': (selectedStatusJobs.isNotEmpty) ? selectedStatusJobs.join(", ") : '',
    };
    Navigator.pop(context, formData); // Trả về dữ liệu cho màn hình cha
  }

  bool _validateDates() {
    if (fromDateController.text.isNotEmpty && toDateController.text.isNotEmpty) {
      final fromDate = DateTime.parse(fromDateController.text);
      final toDate = DateTime.parse(toDateController.text);
      if (toDate.isBefore(fromDate)) {
        setState(() {
          toDateError = AppLocalizations.of(context).translate('error_condition_search');
        });
        return false;
      }
    }
    setState(() {
      toDateError = null;
    });
    return true;
  }


  @override
  Widget build(BuildContext context) {
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
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate('vin_number'),
              prefixIcon: const Icon(Icons.directions_car),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          // Installation Date From
          TextField(
            controller: fromDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate('from_date'),
              prefixIcon: const Icon(Icons.date_range),
              border: const OutlineInputBorder(),
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
                  fromDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  _validateDates();
                });
              }
            },
          ),
          const SizedBox(height: 16),
          // Installation Date To
          TextField(
            controller: toDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate('to_date'),
              prefixIcon: const Icon(Icons.date_range),
              border: const OutlineInputBorder(),
              errorText: toDateError,
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
                  toDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  _validateDates();
                });
              }
            },
          ),
          const SizedBox(height: 16),
          // Job Status
          SearchStatusInput(
            label: AppLocalizations.of(context).translate('job_status'),
            options: JobStatus.values,
            initialSelectedItems: selectedStatusJobs.join(", "),
            notEditing: false,
            onChanged: (selectedValues) {
              setState(() {
                selectedStatusJobs = selectedValues;
              });
            },
          ),
          const SizedBox(height: 24),
          // Buttons
          Row(
            children: [
              // Clear Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.grey[300],
                    elevation: 0,
                  ),
                  onPressed: () {
                    setState(() {
                      vinNoController.clear();
                      fromDateController.clear();
                      toDateController.clear();
                      selectedStatusJobs = [];
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('clear_condition'),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Search Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.green,
                    elevation: 2,
                  ),
                  onPressed: conditions,
                  child: Text(
                    AppLocalizations.of(context).translate('search_list'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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