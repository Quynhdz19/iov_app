import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/group_header.dart';
import '../widgets/inspection_item_card.dart';
import '../widgets/add_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mockData = [
      {
        'dateTime': '3/15/2023 10:57:13 PM',
        'items': [
          {
            'imageUrl': 'https://file.kelleybluebookimages.com/kbb/base/evox/CP/14385/2021-Kia-Seltos-side_14385_001_2400x1800_GAG.png?crop=1.0xw:0.90xh;left,top&downsize=110:*',
            'vehicleNumber': '70-1220',
            'description': 'ติดตั้งใหม่',
          },
        ],
      },
      {
        'dateTime': '3/15/2023 7:20:15 PM',
        'items': [
          {
            'imageUrl': 'https://file.kelleybluebookimages.com/kbb/base/evox/CP/14385/2021-Kia-Seltos-side_14385_001_2400x1800_GAG.png?crop=1.0xw:0.90xh;left,top&downsize=110:*',
            'vehicleNumber': '70-1220',
            'description': 'ซ่อมแซม/แก้ไข',
          },
          {
            'imageUrl': 'https://file.kelleybluebookimages.com/kbb/base/evox/CP/14385/2021-Kia-Seltos-side_14385_001_2400x1800_GAG.png?crop=1.0xw:0.90xh;left,top&downsize=110:*',
            'vehicleNumber': '86-9908',
            'description': 'ติดตั้งใหม่',
          },
        ],
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(
        itemCount: mockData.length,
        itemBuilder: (context, index) {
          final group = mockData[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GroupHeader(
                dateTime: group['dateTime'],
                itemCount: group['items']?.length,
              ),
              ...group['items']?.map<Widget>((item) {
                return InspectionItemCard(
                  imageUrl: item['imageUrl'],
                  vehicleNumber: item['vehicleNumber'],
                  description: item['description'],
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/inspectionForm');
                  },
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}