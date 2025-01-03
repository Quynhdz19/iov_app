import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/local/app_localizations.dart';
import '../../drawer/drawer_menu.dart';
import '../profilemodels/profile_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<void> _profileLoadFuture;

  @override
  void initState() {
    super.initState();
    _profileLoadFuture = Provider.of<ProfileModel>(context, listen: false).loadProfileFromToken();
  }

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
              setState(() {
                _profileLoadFuture = userDetails.loadProfileFromToken();
              });
            },
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: FutureBuilder(
        future: _profileLoadFuture,
        builder: (context, snapshot) {
          if (userDetails.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                AppLocalizations.of(context).translate('not_found'),
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                const SizedBox(height: 24),
                _buildDetailRow(AppLocalizations.of(context).translate('user_name'), userDetails.name ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context).translate('real_name'), userDetails.realName ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context).translate('nick_name'), userDetails.nickname ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context).translate('Position'), userDetails.position ?? 'N/A'),
                _buildPhoneRow(AppLocalizations.of(context).translate('phone_number'), userDetails.phoneNumber ?? 'N/A', Icons.call),
                _buildPhoneRow(
                  AppLocalizations.of(context).translate('Telephone_reserve'),
                  userDetails.backupPhoneNumber ?? 'N/A',
                  Icons.message,
                ),
                _buildEmailRow(AppLocalizations.of(context).translate('email'), userDetails.email ?? 'N/A'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
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