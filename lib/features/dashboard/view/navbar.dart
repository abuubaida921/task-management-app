import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({super.key, required this.currentIndex, required this.onChanged});

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