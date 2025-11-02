import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razinsoft_task_management/core/config/app_color.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _HomePage(
                taskTabIndex: _taskTabIndex,
                onTabChanged: (i) => setState(() => _taskTabIndex = i),
              ),
              _PlaceholderPage(title: 'Tasks'),
              _PlaceholderPage(title: 'Calendar'),
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
  const _FloatingNavBar({
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
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          )
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
          color: isActive ? const Color(0xFF6C46FF).withValues(alpha: 0.12) : Colors.transparent,
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

class _HomePage extends StatelessWidget {
  const _HomePage({
    required this.taskTabIndex,
    required this.onTabChanged,
  });

  final int taskTabIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final dateStr = '${now.day.toString().padLeft(2, '0')} ${_monthName(now.month)}, ${now.year}';

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good morning Liam!',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: AppStaticColor.greetingTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              dateStr,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: AppStaticColor.timeTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/icons/ic_notification.png', width: 24.r, height: 24.r),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Summary',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          title: 'Assigned tasks',
                          value: '21',
                          borderColor: AppStaticColor.primaryColor,
                          valueColor: AppStaticColor.primaryColor,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _SummaryCard(
                          title: 'Completed tasks',
                          value: '31',
                          borderColor: AppStaticColor.completedTaskTextColor,
                          valueColor: AppStaticColor.completedTaskTextColor
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    'Today tasks',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppStaticColor.timeTextColor
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _TasksSegment(
                    index: taskTabIndex,
                    onChanged: onTabChanged,
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, i) {
              final isComplete = i.isEven && taskTabIndex == 1 || (taskTabIndex == 0 && i % 3 == 0);
              if (taskTabIndex == 1 && !isComplete) return const SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _TaskCard(
                  title: i % 2 == 0
                      ? 'Homepage Redesign'
                      : 'E-commerce Checkout Process Redesign',
                  description:
                      'Redesign the ${i % 2 == 0 ? 'homepage' : 'checkout process'} of our website to improve user engagement and align with our updated brand. Focusing on improving conversion...',
                  dateLabel: i % 2 == 0 ? 'October 15, 2023' : 'December 10, 2023',
                  status: isComplete ? _TaskStatus.complete : _TaskStatus.todo,
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemCount: 6,
          ),
          SliverToBoxAdapter(child: SizedBox(height: 120.h)),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.borderColor,
    required this.valueColor,
  });

  final String title;
  final String value;
  final Color borderColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: borderColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor.withValues(alpha: 0.6), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _TasksSegment extends StatelessWidget {
  const _TasksSegment({
    required this.index,
    required this.onChanged,
  });

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(color: const Color(0xFFE6E6F0)),
      ),
      child: Row(
        children: [
          _SegmentItem(
            label: 'All tasks',
            selected: index == 0,
            onTap: () => onChanged(0),
          ),
          _SegmentItem(
            label: 'Completed',
            selected: index == 1,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class _SegmentItem extends StatelessWidget {
  const _SegmentItem({
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
            style: TextStyle(fontSize: 14,
              color: selected ? Colors.white : const Color(0xFF6C46FF),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

enum _TaskStatus { todo, complete }

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.title,
    required this.description,
    required this.dateLabel,
    required this.status,
  });

  final String title;
  final String description;
  final String dateLabel;
  final _TaskStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF81829B),
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 18, color: Color(0xFF81829B)),
              SizedBox(width: 6.w),
              Text(
                dateLabel,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF81829B),
                ),
              ),
              const Spacer(),
              _StatusChip(status: status),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final _TaskStatus status;

  @override
  Widget build(BuildContext context) {
    final isComplete = status == _TaskStatus.complete;
    final bg = isComplete ? const Color(0xFFE8FFF3) : const Color(0xFFEDE3FF);
    final fg = isComplete ? const Color(0xFF2FB365) : const Color(0xFF6C46FF);
    final label = isComplete ? 'Complete' : 'Todo';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
