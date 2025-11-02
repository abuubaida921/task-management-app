import 'package:flutter/material.dart';

import '../../common/error_view.dart';
import '../../features/no_internet/view/no_internet_view.dart';
import '../config/slide_right_route.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash-page':
        return SlideRightRoute(page: const NoInternetPage());
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
