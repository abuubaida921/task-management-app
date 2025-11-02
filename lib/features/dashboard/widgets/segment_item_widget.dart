
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razinsoft_task_management/core/config/app_color.dart';

class SegmentItem extends StatelessWidget {
  const SegmentItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(32.r),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 6.h),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF6C46FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(32.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: selected ? Colors.white : AppStaticColor.greetingTextColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}