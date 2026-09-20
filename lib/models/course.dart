import 'dart:convert';

class Course {
  final String id;
  final String title;
  final String day; // e.g. Mon, Tue
  final String startTime; // ISO or HH:mm
  final String endTime;

  Course({
    required this.id,
    required this.title,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json['id'] as String,
        title: json['title'] as String,
        day: json['day'] as String,
        startTime: json['startTime'] as String,
        endTime: json['endTime'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'day': day,
        'startTime': startTime,
        'endTime': endTime,
      };

  static List<Course> listFromJson(String jsonString) {
    final data = jsonDecode(jsonString) as List<dynamic>;
    return data.map((e) => Course.fromJson(e as Map<String, dynamic>)).toList();
  }

  static String listToJson(List<Course> list) {
    final data = list.map((e) => e.toJson()).toList();
    return jsonEncode(data);
  }
}
