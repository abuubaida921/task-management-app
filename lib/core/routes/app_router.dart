import 'package:flutter/material.dart';
import 'package:razinsoft_task_management/features/splash/view/splash_screen.dart';
import 'package:razinsoft_task_management/features/dashboard/view/dashboard_screen.dart';

import '../../common/error_view.dart';
import '../../features/no_internet/view/no_internet_view.dart';
import '../config/slide_right_route.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash-page':
        return SlideRightRoute(page: const SplashScreen());
      case '/dashboard-page':
        return SlideRightRoute(page: const DashboardScreen());
      case '/no-internet':
        return SlideRightRoute(page: const NoInternetPage());
      default:
        return SlideRightRoute(
          page:  Scaffold(
            body: ErrorView(
              message: 'No route defined for ${settings.name}',
            ),
          ),
        );
    }
  }
}
