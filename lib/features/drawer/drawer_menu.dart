import 'package:flutter/material.dart';
import 'package:iov_app/core/constants/app_colors.dart';
import '../../../core/local/app_localizations.dart';
import '../../core/utils/navigation_utils.dart';

class DrawerMenu extends StatelessWidget {
  final String userEmail;

  const DrawerMenu({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header với Logo và Tiêu đề
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
          // Danh sách các mục menu
          ListTile(
            leading: const Icon(Icons.assignment),
            title: Text(AppLocalizations.of(context).translate('inspections')),
            onTap: () {
              navigateToRouteWithAnimationTo(
                context:  context,
                routeName:'/home',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.stacked_bar_chart),
            title: Text(AppLocalizations.of(context).translate('Kpi')),
            onTap: () {
              navigateToRouteWithAnimationTo(
                context:  context,
                routeName:'/kpi',
              );
            },
          ),
          const Spacer(),
          // Phần Tài khoản Email
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(userEmail),
            trailing: const Icon(Icons.keyboard_arrow_down),
            onTap: () {
              navigateToRouteWithAnimationTo(
                  context:  context,
                  routeName:'/detailsScreen',
              );
            },
          ),
        ],
      ),
    );
  }
}