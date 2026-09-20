import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/course.dart';

const _kPrefsKey = 'saved_courses_json';

class ScheduleNotifier extends Notifier<List<Course>> {
  @override
  List<Course> build() {
    // initial empty list; caller should invoke loadFromPrefs()
    return [];
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_kPrefsKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      state = Course.listFromJson(jsonString);
    }
  }

  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPrefsKey, Course.listToJson(state));
  }

  void addCourse(Course c) {
    state = [...state, c];
    saveToPrefs();
  }

  void removeCourse(String id) {
    state = state.where((e) => e.id != id).toList();
    saveToPrefs();
  }

  void updateCourse(Course updated) {
    state = state.map((e) => e.id == updated.id ? updated : e).toList();
    saveToPrefs();
  }
}

final scheduleProvider = NotifierProvider<ScheduleNotifier, List<Course>>(ScheduleNotifier.new);
