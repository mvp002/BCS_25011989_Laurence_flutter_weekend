import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weekly_class_schedule/models/course.dart';
import 'package:weekly_class_schedule/screens/home_screen.dart';

void main() {
  testWidgets('shows empty state when no courses are scheduled', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(courses: []),
      ),
    );

    expect(find.text('No classes scheduled yet'), findsOneWidget);
    expect(find.text('Add your first class to get started.'), findsOneWidget);
  });

  testWidgets('shows course items in list view when courses exist', (tester) async {
    final courses = [
      Course(
        id: '1',
        title: 'Math 101',
        day: 'Mon',
        startTime: '09:00',
        endTime: '10:30',
        location: 'Room 101',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(courses: courses),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Math 101'), findsOneWidget);
    expect(find.text('Mon • 09:00 - 10:30'), findsOneWidget);
  });

  testWidgets('switches to grid view when toggled', (tester) async {
    final courses = [
      Course(
        id: '1',
        title: 'Math 101',
        day: 'Mon',
        startTime: '09:00',
        endTime: '10:30',
        location: 'Room 101',
      ),
      Course(
        id: '2',
        title: 'History 204',
        day: 'Wed',
        startTime: '13:00',
        endTime: '14:30',
        location: 'Room 201',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(courses: courses),
      ),
    );

    await tester.tap(find.byKey(const Key('grid-view-toggle')));
    await tester.pumpAndSettle();

    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
  });

  testWidgets('shows bottom navigation with Home, List, and Grid tabs', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(courses: [
          Course(
            id: '1',
            title: 'Math 101',
            day: 'Mon',
            startTime: '09:00',
            endTime: '10:30',
            location: 'Room 101',
          ),
        ]),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('List'), findsOneWidget);
    expect(find.text('Grid'), findsOneWidget);
  });

  testWidgets('tapping a course opens the detail screen with the passed course', (tester) async {
    final course = Course(
      id: '1',
      title: 'Math 101',
      day: 'Mon',
      startTime: '09:00',
      endTime: '10:30',
      location: 'Room 101',
      notes: 'Bring calculator',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(courses: [course]),
      ),
    );

    await tester.tap(find.text('Math 101'));
    await tester.pumpAndSettle();

    expect(find.text('Course details'), findsOneWidget);
    expect(find.text('Math 101'), findsWidgets);
    expect(find.text('Room 101'), findsOneWidget);
  });
}
