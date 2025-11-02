import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razinsoft_task_management/core/config/app_color.dart';
import 'package:razinsoft_task_management/features/dashboard/view/tabs/home.dart';
import '../widgets/placeholder_widget.dart';
import 'navbar.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int _taskTabIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppStaticColor.whiteColor,
                    AppStaticColor.gradientBottomColor,
                  ],
                ),
              ),
            ),
          ),
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomePage(
                taskTabIndex: _taskTabIndex,
                onTabChanged: (i) => setState(() => _taskTabIndex = i),
              ),
              PlaceholderPage(title: 'Tasks'),
              PlaceholderPage(title: 'Calendar'),
            ],
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 16.h + MediaQuery.of(context).padding.bottom,
            child: FloatingNavBar(
              currentIndex: _currentIndex,
              onChanged: (index) {
                if (_currentIndex == index) return;
                setState(() => _currentIndex = index);
                _pageController.jumpToPage(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

