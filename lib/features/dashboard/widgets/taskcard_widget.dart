import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razinsoft_task_management/features/dashboard/widgets/statuschip_widget.dart';

import '../../../core/config/app_color.dart';
import '../../../core/enums/task_status_enum.dart';
class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.title,
    required this.description,
    required this.dateLabel,
    required this.status,
  });

  final String title;
  final String description;
  final String dateLabel;
  final TaskStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r,),
        border: Border.all(color: AppStaticColor.taskItemBgColor, width: 1),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppStaticColor.greetingTextColor,
              height: 1.4,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 18,
                color: Color(0xFF81829B),
              ),
              SizedBox(width: 6.w),
              Text(
                dateLabel,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppStaticColor.greetingTextColor,
                ),
              ),
              const Spacer(),
              StatusChip(status: status),
            ],
          ),
        ],
      ),
    );
  }
}