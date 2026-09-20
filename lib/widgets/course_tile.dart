import 'package:flutter/material.dart';

import '../models/course.dart';

class CourseTile extends StatelessWidget {
  final Course course;

  const CourseTile({super.key, required this.course});

  Color _resolveColor() {
    if (course.colorHex == null || course.colorHex!.isEmpty) {
      return Colors.indigo;
    }

    final hex = course.colorHex!.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16));
    }
    return Colors.indigo;
  }

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor();
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.22),
              color.withValues(alpha: 0.08),
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12,
              height: 64,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.title, style: textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text(
                    '${course.day} • ${course.startTime} - ${course.endTime}',
                    style: textTheme.bodyMedium,
                  ),
                  if (course.location != null && course.location!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(course.location!, style: textTheme.bodySmall),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: color),
          ],
        ),
      ),
    );
  }
}
