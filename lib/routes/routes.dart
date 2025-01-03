import 'package:flutter/material.dart';
import 'package:iov_app/features/home/screens/home_screen.dart';
import 'package:iov_app/features/kpi/screenkpi/screen_kpi.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/inspectionform/screens/inspection_form_screen.dart';
import '../features/profile/profileScreen/details_screen.dart';
import 'auth_guard.dart';

final Map<String, Widget Function(BuildContext, dynamic)> appRoutes = {
  '/': (context, params) => const LoginScreen(),
  '/home': (context, params) => const AuthGuard(
    child: HomeScreen(),
  ),
  '/inspectionForm': (context, params) => AuthGuard(
    child: InspectionFormScreen(params: params),
  ),
  '/detailsScreen': (context, params) => const AuthGuard(
    child: DetailsScreen(),
  ),
  '/kpi': (context, params) => const AuthGuard(
    child: KpiJobScreen(),
  ),
};