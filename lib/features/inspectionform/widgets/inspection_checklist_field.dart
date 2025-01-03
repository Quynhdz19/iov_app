import 'package:flutter/material.dart';

import '../controller/inspection_checklist_controller.dart';

class CAR_PARAMETER_STATUS {
  static const String REQUIRES_ATTENTION = 'Requires Attention';
  static const String FUTURE_ATTENTION = 'Future Attention';
  static const String OK = 'OK';
  static const String NA = 'N/A';
}

class InspectionChecklistWidget extends StatefulWidget {
  final String label;
  final InspectionChecklistController controller;

  const InspectionChecklistWidget({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  _InspectionChecklistWidgetState createState() =>
      _InspectionChecklistWidgetState();
}

class _InspectionChecklistWidgetState extends State<InspectionChecklistWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildButton(
                  label: CAR_PARAMETER_STATUS.REQUIRES_ATTENTION,
                  isSelected: widget.controller.selectedStatus ==
                      CAR_PARAMETER_STATUS.REQUIRES_ATTENTION,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildButton(
                        label: CAR_PARAMETER_STATUS.FUTURE_ATTENTION,
                        isSelected: widget.controller.selectedStatus ==
                            CAR_PARAMETER_STATUS.FUTURE_ATTENTION,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildButton(
                        label: CAR_PARAMETER_STATUS.OK,
                        isSelected: widget.controller.selectedStatus ==
                            CAR_PARAMETER_STATUS.OK,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildButton(
                  label: CAR_PARAMETER_STATUS.NA,
                  isSelected:
                  widget.controller.selectedStatus == CAR_PARAMETER_STATUS.NA,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({required String label, required bool isSelected}) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          widget.controller.updateStatus(label);
        });
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: isSelected
            ? Colors.blue.shade100
            : const Color.fromRGBO(248, 248, 248, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }
}