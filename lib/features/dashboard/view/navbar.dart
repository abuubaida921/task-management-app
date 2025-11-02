import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razinsoft_task_management/core/config/app_color.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              isActive: currentIndex == 0,
              activeIcon: 'assets/icons/ic_home_active.png',
              inactiveIcon: 'assets/icons/ic_home_inactive.png',
              onTap: () => onChanged(0),
            ),
            NavItem(
              isActive: currentIndex == 1,
              activeIcon: 'assets/icons/ic_clipboard_active.png',
              inactiveIcon: 'assets/icons/ic_clipboard_inactive.png',
              onTap: () => onChanged(1),
            ),
            NavItem(
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

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
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
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(32.r),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(isActive ? 10.r : 6.r),
          decoration: BoxDecoration(
            color: isActive ? AppStaticColor.assignedTaskBgColor.withValues(alpha: .7) : Colors.transparent,
            borderRadius: BorderRadius.circular(32.r),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              isActive ? activeIcon : inactiveIcon,
              width: 20.r,
              height: 20.r,
            ),
          ),
        ),
      ),
    );
  }
}
