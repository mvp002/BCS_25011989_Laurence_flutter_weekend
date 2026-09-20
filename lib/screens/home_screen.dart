import 'package:flutter/material.dart';

import '../models/course.dart';
import '../widgets/course_tile.dart';
import 'course_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Course> courses;

  const HomeScreen({super.key, this.courses = const []});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Course> _visibleCourses;
  bool _showEmptyState = false;
  bool _showGrid = false;

  @override
  void initState() {
    super.initState();
    _visibleCourses = List.of(widget.courses);
  }

  void _toggleView() {
    setState(() {
      _showEmptyState = !_showEmptyState;
      _showGrid = false;
      _visibleCourses = _showEmptyState ? [] : List.of(widget.courses);
    });
  }

  void _toggleLayout() {
    if (_visibleCourses.isEmpty) {
      return;
    }

    setState(() {
      _showGrid = !_showGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavItems = [
      const NavigationDestination(
        icon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.list_rounded),
        label: 'List',
      ),
      const NavigationDestination(
        icon: Icon(Icons.grid_view_rounded),
        label: 'Grid',
      ),
    ];

    final body = _visibleCourses.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.event_note_rounded,
                      size: 44,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No classes scheduled yet',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add your first class to get started.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          )
        : _showGrid
            ? GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: _visibleCourses.length,
                itemBuilder: (context, index) {
                  final course = _visibleCourses[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CourseDetailScreen(course: course),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 8,
                              decoration: BoxDecoration(
                                color: course.colorHex != null && course.colorHex!.isNotEmpty
                                    ? Color(int.parse('FF${course.colorHex!.replaceAll('#', '')}', radix: 16))
                                    : Colors.indigo,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              course.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 6),
                            Text('${course.day} • ${course.startTime}'),
                            const SizedBox(height: 4),
                            Text(course.location ?? 'TBD'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: _visibleCourses.length,
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final course = _visibleCourses[index];
                  return CourseTile(course: course);
                },
              );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Schedule'),
        actions: [
          IconButton(
            key: const Key('grid-view-toggle'),
            onPressed: _toggleLayout,
            icon: Icon(_showGrid ? Icons.view_list_rounded : Icons.grid_view_rounded),
            tooltip: 'Toggle layout',
          ),
          IconButton(
            onPressed: _toggleView,
            icon: const Icon(Icons.swap_horiz_rounded),
            tooltip: 'Toggle list state',
          ),
        ],
      ),
      body: body,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggleView,
        icon: const Icon(Icons.add),
        label: const Text('Add class'),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: bottomNavItems,
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 0) {
            setState(() {
              _showEmptyState = false;
              _showGrid = false;
              _visibleCourses = List.of(widget.courses);
            });
          } else if (index == 1) {
            setState(() {
              _showEmptyState = false;
              _showGrid = false;
              _visibleCourses = List.of(widget.courses);
            });
          } else if (index == 2) {
            setState(() {
              _showEmptyState = false;
              _showGrid = true;
              _visibleCourses = List.of(widget.courses);
            });
          }
        },
      ),
    );
  }
}
