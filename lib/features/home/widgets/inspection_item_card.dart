import 'package:flutter/material.dart';

import '../../../core/utils/navigation_utils.dart';

class InspectionItemCard extends StatelessWidget {
  final int job_id;
  final String imageUrl;
  final String vehicleNumber;
  final String description;
  final VoidCallback onTap; // Thêm tham số onTap

  const InspectionItemCard({
    Key? key,
    required this.job_id,
    required this.imageUrl,
    required this.vehicleNumber,
    required this.description,
    required this.onTap, // Tham số bắt buộc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToRouteWithAnimationTo(
          context:  context,
          routeName:'/inspectionForm',
          params: job_id
        );
      }, // Hàm sẽ chạy khi bấm vào card
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0), // Bo góc với bán kính 8
            child: Image.network(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(vehicleNumber, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(description),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert), onPressed: () {

          },
          ),
        ),
      ),
    );
  }
}