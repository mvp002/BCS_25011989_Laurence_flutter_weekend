import 'package:flutter/material.dart';

import '../models/course.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              _InfoRow(label: 'Day', value: course.day),
              _InfoRow(label: 'Time', value: '${course.startTime} - ${course.endTime}'),
              if (course.location != null && course.location!.isNotEmpty)
                _InfoRow(label: 'Location', value: course.location!),
              if (course.notes != null && course.notes!.isNotEmpty)
                _InfoRow(label: 'Notes', value: course.notes!),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Back to schedule'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.labelLarge?.copyWith(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: textTheme.bodyLarge),
        ],
      ),
    );
  }
}
