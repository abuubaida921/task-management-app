import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razinsoft_task_management/features/dashboard/widgets/segment_item_widget.dart';

class TasksSegment extends StatelessWidget {
  const TasksSegment({super.key, required this.index, required this.onChanged});

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
          SegmentItem(
            label: 'All tasks',
            selected: index == 0,
            onTap: () => onChanged(0),
          ),
          SegmentItem(
            label: 'Completed',
            selected: index == 1,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}