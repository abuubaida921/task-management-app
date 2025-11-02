import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razinsoft_task_management/core/config/app_color.dart';

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
              _HomePage(
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

class _Task {
  final String title;
  final String description;
  final String dateLabel;
  final TaskStatus status;
  const _Task({
    required this.title,
    required this.description,
    required this.dateLabel,
    required this.status,
  });
}

class _HomePage extends StatelessWidget {
  const _HomePage({required this.taskTabIndex, required this.onTabChanged});

  final int taskTabIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr =
        '${now.day.toString().padLeft(2, '0')} ${getMonthName(now.month)}, ${now.year}';


    final List<_Task> tasks = const [
      _Task(
        title: 'Homepage Redesign',
        description:
            'Revamp the homepage to align with the latest brand guidelines and improve engagement metrics.',
        dateLabel: 'October 15, 2023',
        status: TaskStatus.todo,
      ),
      _Task(
        title: 'Checkout Flow Optimization',
        description:
            'Analyze and redesign the checkout steps to reduce drop-offs and improve conversion.',
        dateLabel: 'December 10, 2023',
        status: TaskStatus.complete,
      ),
      _Task(
        title: 'Push Notification Setup',
        description:
            'Integrate FCM and create topic-based notifications for marketing campaigns.',
        dateLabel: 'November 07, 2023',
        status: TaskStatus.todo,
      ),
      _Task(
        title: 'User Onboarding Revamp',
        description:
            'Shorten onboarding and add progress indicators to increase completion rate.',
        dateLabel: 'November 22, 2023',
        status: TaskStatus.complete,
      ),
      _Task(
        title: 'Dark Mode QA',
        description:
            'Test dark mode across modules and fix contrast and accessibility issues.',
        dateLabel: 'January 04, 2024',
        status: TaskStatus.todo,
      ),
      _Task(
        title: 'Analytics Dashboard',
        description:
            'Build a product analytics dashboard with funnels and retention cohorts.',
        dateLabel: 'February 12, 2024',
        status: TaskStatus.complete,
      ),
    ];


    final List<_Task> filteredTasks = taskTabIndex == 1
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
