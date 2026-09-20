import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/course.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final demoCourses = [
    Course(
      id: '1',
      title: 'Math 101',
      day: 'Mon',
      startTime: '09:00',
      endTime: '10:30',
      location: 'Room 101',
      colorHex: '#5C6BC0',
    ),
    Course(
      id: '2',
      title: 'English Lit',
      day: 'Tue',
      startTime: '11:00',
      endTime: '12:30',
      location: 'Room 204',
      colorHex: '#26A69A',
    ),
    Course(
      id: '3',
      title: 'Design Studio',
      day: 'Thu',
      startTime: '14:00',
      endTime: '16:00',
      location: 'Lab 5',
      colorHex: '#FF8A65',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Class Schedule',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: HomeScreen(courses: demoCourses),
    );
  }
}
