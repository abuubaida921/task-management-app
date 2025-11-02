import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razinsoft_task_management/core/config/app_color.dart';
import 'package:razinsoft_task_management/features/dashboard/view/tabs/home.dart';

import '../../../core/enums/task_status_enum.dart';
import '../../../core/utils/month_helper.dart';
import '../widgets/placeholder_widget.dart';
import '../widgets/summarycard_widget.dart';
import '../widgets/taskcard_widget.dart';
import '../widgets/tasksegment_widget.dart';

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
          // Floating bottom navigation bar
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 16.h + MediaQuery.of(context).padding.bottom,
            child: _FloatingNavBar(
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

class _FloatingNavBar extends StatelessWidget {
  const _FloatingNavBar({required this.currentIndex, required this.onChanged});

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavItem(
              isActive: currentIndex == 0,
              activeIcon: 'assets/icons/ic_home_active.png',
              inactiveIcon: 'assets/icons/ic_home_inactive.png',
              onTap: () => onChanged(0),
            ),
            _NavItem(
              isActive: currentIndex == 1,
              activeIcon: 'assets/icons/ic_clipboard_active.png',
              inactiveIcon: 'assets/icons/ic_clipboard_inactive.png',
              onTap: () => onChanged(1),
            ),
            _NavItem(
              isActive: currentIndex == 2,
              activeIcon: 'assets/icons/ic_calender_active.png',
              inactiveIcon: 'assets/icons/ic_calender_inactive.png',
              onTap: () => onChanged(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.isActive,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.onTap,
  });

  final bool isActive;
  final String activeIcon;
  final String inactiveIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(isActive ? 10.r : 6.r),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF6C46FF).withValues(alpha: 0.12)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          isActive ? activeIcon : inactiveIcon,
          width: 28.r,
          height: 28.r,
        ),
      ),
    );
  }
}

