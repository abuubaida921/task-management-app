import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/app_color.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key,});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  static const int _descMaxLen = 45;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final initial = (isStart ? _startDate : _endDate) ?? now;
    final first = DateTime(now.year - 5);
    final last = DateTime(now.year + 5);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppStaticColor.primaryColor,
                  surface: Colors.white,
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
          if (_startDate != null && _endDate!.isBefore(_startDate!)) {
            _startDate = _endDate;
          }
        }
      });
    }
  }

  String _fmtDate(DateTime? d) {
    if (d == null) return '';
    final months = const [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[d.month - 1]} ${d.day.toString().padLeft(2, '0')}, ${d.year}';
  }

  InputDecoration _roundedInputDecoration({required String hint, Widget? suffix}) {
    final borderColor = const Color(0xFFE6E6F0);
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 12.sp,color: AppStaticColor.greetingTextColor),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      suffixIcon: suffix != null ? Padding(padding: EdgeInsets.only(right: 8.w), child: suffix) : null,
      suffixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(color: AppStaticColor.primaryColor, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
            child: Text(
              'Create new task',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F0F1A),
                  ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h + topPad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Name',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F0F1A),
                        ),
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: _nameCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: _roundedInputDecoration(hint: 'Enter Your Task Name'),
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    'Task description',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F0F1A),
                        ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: const Color(0xFFE6E6F0)),
                    ),
                    child: Stack(
                      children: [
                        TextField(
                          controller: _descCtrl,
                          maxLines: 5,
                          maxLength: _descMaxLen,
                          buildCounter: (context, {required currentLength, required isFocused, maxLength}) => const SizedBox.shrink(),
                          decoration: InputDecoration(
                            hintText:
                                'Optimize the user interface for our mobile app, ensuring a seamless and delightful user experience. Consider incorporating user feedback and modern design trends to enhance usability and aesthetics.. Consider incorporating user feedback and modern design trends to enhance usability and aesthetics.',
                            hintStyle: TextStyle(fontSize: 12.sp,color: AppStaticColor.greetingTextColor),
                            hintMaxLines: 5,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(16.r),
                            border: InputBorder.none,
                          ),
                        ),
                        Positioned(
                          right: 12.w,
                          bottom: 8.h,
                          child: AnimatedBuilder(
                            animation: _descCtrl,
                            builder: (_, __) {
                              final len = _descCtrl.text.length;
                              return Text(
                                '${len.toString()}/${_descMaxLen.toString()}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppStaticColor.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Dates label row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Start Date',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F0F1A),
                              ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Text(
                          'End Date',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F0F1A),
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          onTap: () => _pickDate(isStart: true),
                          style: TextStyle(fontSize: 10.sp,color: AppStaticColor.greetingTextColor),
                          controller: TextEditingController(text: _fmtDate(_startDate).isEmpty ? 'October 15, 2023' : _fmtDate(_startDate)),
                          decoration: _roundedInputDecoration(
                            hint: 'October 15, 2023',
                            suffix: _CalendarSuffix(onTap: () => _pickDate(isStart: true)),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          onTap: () => _pickDate(isStart: false),
                          style: TextStyle(fontSize: 10.sp,color: AppStaticColor.greetingTextColor),
                          controller: TextEditingController(text: _fmtDate(_endDate).isEmpty ? 'October 15, 2023' : _fmtDate(_endDate)),
                          decoration: _roundedInputDecoration(
                            hint: 'October 15, 2023',
                            suffix: _CalendarSuffix(onTap: () => _pickDate(isStart: false)),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 28.h),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStaticColor.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Task created')),
                        );
                      },
                      child: Text(
                        'Create new tasks',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarSuffix extends StatelessWidget {
  const _CalendarSuffix({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9.r),
      child: SizedBox(
        width: 36.r,
        height: 36.r,
        child: Icon(
          Icons.calendar_today_rounded,
          size: 15.r,
          color: AppStaticColor.primaryColor,
        ),
      ),
    );
  }
}