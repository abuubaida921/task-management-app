import 'package:flutter/material.dart';
import 'package:razinsoft_task_management/core/routes/app_routes.dart';
import 'package:razinsoft_task_management/features/splash/view/splash_screen.dart';
import 'package:razinsoft_task_management/features/dashboard/view/dashboard_screen.dart';

import '../../common/error_view.dart';
import '../../features/dashboard/view/task_details_screen.dart';
import '../../features/no_internet/view/no_internet_view.dart';
import '../config/slide_right_route.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return SlideRightRoute(page: const SplashScreen());
      case AppRoutes.dashboard:
        return SlideRightRoute(page: const DashboardScreen());
      case AppRoutes.noInternet:
        return SlideRightRoute(page: const NoInternetPage());
      case AppRoutes.taskDetailsScreen:
        return SlideRightRoute(page: const TaskDetailsScreen());
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
