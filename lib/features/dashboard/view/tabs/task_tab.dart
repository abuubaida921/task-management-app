import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/enums/task_status_enum.dart';
import '../../../../core/utils/month_helper.dart';
import '../../models/task_model.dart';
import '../../widgets/summarycard_widget.dart';
import '../../widgets/taskcard_widget.dart';
import '../../widgets/tasksegment_widget.dart';


class TaskPage extends StatelessWidget {
  const TaskPage({required this.taskTabIndex, required this.onTabChanged});

  final int taskTabIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr =
        '${now.day.toString().padLeft(2, '0')} ${getMonthName(now.month)}, ${now.year}';


    final List<Task> tasks = const [
      Task(
        title: 'Homepage Redesign',
        description:
        'Revamp the homepage to align with the latest brand guidelines and improve engagement metrics.',
        dateLabel: 'October 15, 2023',
        status: TaskStatus.todo,
      ),
      Task(
        title: 'Checkout Flow Optimization',
        description:
        'Analyze and redesign the checkout steps to reduce drop-offs and improve conversion.',
        dateLabel: 'December 10, 2023',
        status: TaskStatus.complete,
      ),
      Task(
        title: 'Push Notification Setup',
        description:
        'Integrate FCM and create topic-based notifications for marketing campaigns.',
        dateLabel: 'November 07, 2023',
        status: TaskStatus.todo,
      ),
      Task(
        title: 'User Onboarding Revamp',
        description:
        'Shorten onboarding and add progress indicators to increase completion rate.',
        dateLabel: 'November 22, 2023',
        status: TaskStatus.complete,
      ),
      Task(
        title: 'Dark Mode QA',
        description:
        'Test dark mode across modules and fix contrast and accessibility issues.',
        dateLabel: 'January 04, 2024',
        status: TaskStatus.todo,
      ),
      Task(
        title: 'Analytics Dashboard',
        description:
        'Build a product analytics dashboard with funnels and retention cohorts.',
        dateLabel: 'February 12, 2024',
        status: TaskStatus.complete,
      ),
    ];


    final List<Task> filteredTasks = taskTabIndex == 1
        ? tasks.where((t) => t.status == TaskStatus.complete).toList()
        : tasks;

    return SafeArea(
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good morning Liam!',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppStaticColor.greetingTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        dateStr,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppStaticColor.timeTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/icons/ic_notification.png',
                    width: 24.r,
                    height: 24.r,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    // Top padding is 0 because header already provided top spacing
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          'Summary',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: SummaryCard(
                                title: 'Assigned tasks',
                                value: '21',
                                bgColor: AppStaticColor.assignedTaskBgColor,
                                borderColor: AppStaticColor.primaryColor,
                                valueColor: AppStaticColor.primaryColor,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: SummaryCard(
                                title: 'Completed tasks',
                                value: '31',
                                bgColor: AppStaticColor.completedTaskBgColor,
                                borderColor:
                                AppStaticColor.completedTaskTextColor,
                                valueColor:
                                AppStaticColor.completedTaskTextColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),
                        Text(
                          'Today tasks',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppStaticColor.timeTextColor,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        TasksSegment(index: taskTabIndex, onChanged: onTabChanged),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ),
                ),
                if (filteredTasks.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                      child: Center(
                        child: Text(
                          'No tasks to show',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppStaticColor.timeTextColor,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SliverList.separated(
                    itemBuilder: (context, i) {
                      final task = filteredTasks[i];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: TaskCard(
                          title: task.title,
                          description: task.description,
                          dateLabel: task.dateLabel,
                          status: task.status,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemCount: filteredTasks.length,
                  ),
                SliverToBoxAdapter(child: SizedBox(height: 120.h)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}