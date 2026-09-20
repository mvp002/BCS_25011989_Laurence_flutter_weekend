import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  final String title;
  final String time;

  const CourseTile({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(time, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
