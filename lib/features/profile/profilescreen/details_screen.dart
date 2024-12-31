import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../drawer/drawer_menu.dart';
import '../profilemodels/profile_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<ProfileModel>(context);

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
              // Xử lý làm mới
            },
          ),
        ],
      ),
      drawer: const DrawerMenu(userEmail: 'balloon28th@gmail.com'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(
                Icons.person,
                size: 80,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('User name', userDetails.name ?? 'N/A'),
            _buildDetailRow('Real name', userDetails.realName ?? 'N/A'),
            _buildDetailRow('Nick name', userDetails.nickname ?? 'N/A'),
            _buildDetailRow('Position', userDetails.position ?? 'N/A'),
            _buildPhoneRow('Phone number', userDetails.phoneNumber ?? 'N/A', Icons.call),
            _buildPhoneRow('Telephone number (reserve)', userDetails.backupPhoneNumber ?? 'N/A', Icons.message),
            _buildEmailRow('Email', userDetails.email ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildPhoneRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
          IconButton(
            onPressed: () {
              // Xử lý hành động (gọi/sms)
            },
            icon: Icon(icon, color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
          IconButton(
            onPressed: () {
              // Xử lý email
            },
            icon: const Icon(Icons.email, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}