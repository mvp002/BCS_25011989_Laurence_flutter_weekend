import 'dart:convert';

import 'course.dart';

class Schedule {
  final String id;
  final String name;
  final List<Course> courses;

  Schedule({required this.id, required this.name, required this.courses});

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json['id'] as String,
        name: json['name'] as String,
        courses: (json['courses'] as List<dynamic>)
            .map((e) => Course.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'courses': courses.map((e) => e.toJson()).toList(),
      };

  static List<Schedule> listFromJson(String jsonString) {
    final data = jsonDecode(jsonString) as List<dynamic>;
    return data
        .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listToJson(List<Schedule> list) {
    final data = list.map((e) => e.toJson()).toList();
    return jsonEncode(data);
  }
}
