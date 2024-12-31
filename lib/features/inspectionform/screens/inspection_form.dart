import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/navigation_utils.dart';
import '../widgets/custom_add_field.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_dropdown_field.dart';
import '../widgets/custom_location_field.dart';
import '../widgets/custom_photo_field.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/inspection_checklist_field.dart';

class InspectionForm extends StatelessWidget {
  final dynamic params;
  const InspectionForm({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    print('Params received: $params');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspections Form'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigateToRouteWithAnimationBack(
              context: context,
              routeName: '/home',
            );
          },
        ),
      ),
      body: Column(
        children: [
          // Nội dung biểu mẫu
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  CustomTextField(label: 'Sale Order'),
                  CustomTextField(label: 'Ticket No.'),
                  CustomTextField(label: 'Doc No.'),
                  CustomAddField(label: 'Installation Type'),
                  CustomAddField(label: 'Accessories'),
                  CustomTextField(label: 'Notes'),
                  CustomDatePicker(label: 'Installation Date'),
                  CustomLocationField(label: 'Installation Location'),
                  CustomDropdownField(
                    label: 'Odometer Reading',
                    items: ['Option 1', 'Option 2', 'Option 3'],
                  ),
                  CustomPhotoField(label: 'Front View'),
                  CustomPhotoField(label: 'Back View'),
                  CustomPhotoField(label: 'Car Chassis'),
                  CustomPhotoField(label: 'GPS Devices'),
                  CustomPhotoField(label: 'Antenna GPS/GSM'),
                  CustomPhotoField(label: 'Before Installation'),
                  CustomPhotoField(label: 'After Installation'),
                  CustomPhotoField(label: 'Additional Equipment (1)'),
                  CustomPhotoField(label: 'Additional Equipment (2)'),
                  CustomPhotoField(label: 'Additional Images'),
                  InspectionChecklistWidget(label: 'Engine Oil'),
                  InspectionChecklistWidget(label: 'Transmission'),
                  InspectionChecklistWidget(label: 'Differential'),
                  CustomTextField(label: 'Other'),
                ],
              ),
            ),
          ),

          // Save and Cancel
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel Button
                InkWell(
                  onTap: () {
                    navigateToRouteWithAnimationBack(
                      context: context,
                      routeName: '/home',
                    );
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Save Button
                InkWell(
                  onTap: () {
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}