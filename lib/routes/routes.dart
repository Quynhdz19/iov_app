import 'package:flutter/material.dart';
import 'package:iov_app/features/home/screens/home_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/inspectionform/screens/inspection_form.dart';
import 'auth_guard.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LoginScreen(),
  '/home': (context) => const AuthGuard(
    child: HomeScreen(),
  ),
  '/inspectionForm': (context) => const AuthGuard(
    child: InspectionForm(),
  ),
};