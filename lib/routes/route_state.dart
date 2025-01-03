import 'package:flutter/material.dart';

class RouteState with ChangeNotifier {
  String? _currentRoute;

  String? get currentRoute => _currentRoute;

  void setCurrentRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }
}