import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home/widgets/custom_app_bar.dart';
import '../widgets/custom_add_field.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_dropdown_field.dart';
import '../widgets/custom_location_field.dart';
import '../widgets/custom_photo_field.dart';
import '../widgets/custom_text_field.dart';

class InspectionForm extends StatelessWidget {
  const InspectionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            CustomTextField(label: 'Sale Order'),
            CustomTextField(label: 'Ticket No.'),
            CustomTextField(label: 'Doc No.'),
            CustomAddField(label: 'ประเภทการติดตั้ง'),
            CustomAddField(label: 'อุปกรณ์เสริม'),
            CustomTextField(label: 'หมายเหตุ'),
            CustomDatePicker(label: 'วันที่นัดหมาย'),
            CustomLocationField(label: 'สถานที่นัดหมาย'),
            CustomDropdownField(
              label: 'ทะเบียนรถ',
              items: ['Option 1', 'Option 2', 'Option 3'],
            ),
            CustomTextField(label: 'Odometer reading'),
            CustomPhotoField(label: 'รูปถ่ายหน้ารถ'),
            CustomPhotoField(label: 'รูปถ่ายหลังรถ'),
          ],
        ),
      ),
    );
  }
}