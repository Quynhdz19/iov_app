import 'package:flutter/material.dart';
import '../../routes/route_state.dart';
import '../../routes/routes.dart';
import 'package:iov_app/routes/routes.dart'; // File chứa appRoutes
import 'package:provider/provider.dart';

void navigateToRouteWithAnimationTo({
  required BuildContext context,
  required String routeName,
  Offset beginOffset = const Offset(1.0, 0.0),
  Duration duration = const Duration(milliseconds: 500),
  dynamic params, // Tham số bổ sung
}) {
  // Lấy Widget từ appRoutes
  final routeBuilder = appRoutes[routeName];

  if (routeBuilder != null) {
    Provider.of<RouteState>(context, listen: false).setCurrentRoute(routeName);
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            routeBuilder(context, params), // Truyền params vào routeBuilder
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var tween = Tween(begin: beginOffset, end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeInOut));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: duration,
      ),
    );
  } else {
    throw Exception("Route '$routeName' không được định nghĩa trong appRoutes");
  }
}
void navigateToRouteWithAnimationBack({
  required BuildContext context,
  required String routeName,
  Offset beginOffset = const Offset(-1.0, 0.0),
  Duration duration = const Duration(milliseconds: 500),
  dynamic params, // Tham số bổ sung
}) {
  // Lấy Widget từ appRoutes
  final routeBuilder = appRoutes[routeName];

  if (routeBuilder != null) {
    Provider.of<RouteState>(context, listen: false).setCurrentRoute(routeName);
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => routeBuilder(context, params),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var tween = Tween(begin: beginOffset, end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeInOut));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: duration,
      ),
    );
  } else {
    throw Exception("Route '$routeName' không được định nghĩa trong appRoutes");
  }
}