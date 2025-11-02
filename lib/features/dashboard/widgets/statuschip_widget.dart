import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/app_color.dart';
import '../../../core/enums/task_status_enum.dart';
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final TaskStatus status;

  @override
  Widget build(BuildContext context) {
    final isComplete = status == TaskStatus.complete;
    final bg = isComplete ? AppStaticColor.completedTaskBgColor
        : AppStaticColor.assignedTaskBgColor;
    final fg = isComplete
        ? AppStaticColor.completedTaskTextColor
        : AppStaticColor.primaryColor;
    final label = isComplete ? 'Complete' : 'Todo';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(color: fg, fontWeight: FontWeight.w800),
      ),
    );
  }
}