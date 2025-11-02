import '../../../core/enums/task_status_enum.dart';

class Task {
  final String title;
  final String description;
  final String dateLabel;
  final TaskStatus status;
  const Task({
    required this.title,
    required this.description,
    required this.dateLabel,
    required this.status,
  });
}