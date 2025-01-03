import 'package:flutter/material.dart';
import 'package:iov_app/core/constants/app_colors.dart';
import '../../../core/local/app_localizations.dart';
import '../../core/utils/navigation_utils.dart';
import 'package:provider/provider.dart';

import '../../routes/route_state.dart';

class DrawerMenu extends StatelessWidget {
  final String userEmail;

  const DrawerMenu({Key? key, required this.userEmail}) : super(key: key);

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
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(userEmail),
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
          ),
        ],
      ),
    );
  }
}