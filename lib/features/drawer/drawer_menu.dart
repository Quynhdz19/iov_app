import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iov_app/core/constants/app_colors.dart';
import 'package:iov_app/core/local/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../core/utils/navigation_utils.dart';
import '../../routes/route_state.dart';
import '../../core/utils/storage_util.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  Future<String> _getUserEmail() async {
    final accessToken = await StorageUtil.getString('access_token');
    if (accessToken != null) {
      try {
        final payload = accessToken.split('.')[1]; // Lấy phần payload từ JWT
        final normalizedPayload = base64.normalize(payload);
        final decodedPayload = utf8.decode(base64.decode(normalizedPayload));
        final payloadMap = json.decode(decodedPayload);
        return payloadMap['email'] ?? 'Unknown Email';
      } catch (e) {
        return 'Invalid Token';
      }
    }
    return 'No Access Token';
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = Provider.of<RouteState>(context).currentRoute ?? '/home';

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Onelink',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: Text(AppLocalizations.of(context).translate('inspections')),
            selected: currentRoute == '/home',
            selectedTileColor: AppColors.primaryColor.withOpacity(0.2),
            onTap: () {
              if (currentRoute != '/home') {
                navigateToRouteWithAnimationTo(
                  context: context,
                  routeName: '/home',
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.stacked_bar_chart),
            title: Text(AppLocalizations.of(context).translate('Kpi')),
            selected: currentRoute == '/kpi',
            selectedTileColor: AppColors.primaryColor.withOpacity(0.2),
            onTap: () {
              if (currentRoute != '/kpi') {
                navigateToRouteWithAnimationTo(
                  context: context,
                  routeName: '/kpi',
                );
              }
            },
          ),
          const Spacer(),
          FutureBuilder<String>(
            future: _getUserEmail(),
            builder: (context, snapshot) {
              final userEmail = snapshot.data ?? 'Loading...';
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  userEmail,
                  overflow: TextOverflow.ellipsis, // Hiển thị dấu ... khi quá dài
                  maxLines: 1, // Giới hạn 1 dòng
                  style: const TextStyle(color: Colors.black),
                ),
                selected: currentRoute == '/detailsScreen',
                selectedTileColor: AppColors.primaryColor.withOpacity(0.2),
                trailing: const Icon(Icons.keyboard_arrow_down),
                onTap: () {
                  if (currentRoute != '/detailsScreen') {
                    navigateToRouteWithAnimationTo(
                      context: context,
                      routeName: '/detailsScreen',
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}