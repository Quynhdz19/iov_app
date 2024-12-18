import 'package:flutter/material.dart';

class InspectionItemCard extends StatelessWidget {
  final String imageUrl;
  final String vehicleNumber;
  final String description;
  final VoidCallback onTap; // Thêm tham số onTap

  const InspectionItemCard({
    Key? key,
    required this.imageUrl,
    required this.vehicleNumber,
    required this.description,
    required this.onTap, // Tham số bắt buộc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Hàm sẽ chạy khi bấm vào card
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(vehicleNumber, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(description),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert), onPressed: () {  },
          ),
        ),
      ),
    );
  }
}