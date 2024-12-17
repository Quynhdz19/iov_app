import 'package:flutter/material.dart';
import 'package:iov_app/features/home/screens/home_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/inspectionform/screens/inspection_form.dart';
import 'auth_guard.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/inspectionForm': (context) => const InspectionForm(),
  // '/home': (context) => AuthGuard(
  //   child: const HomeScreen(),
  // ),
};