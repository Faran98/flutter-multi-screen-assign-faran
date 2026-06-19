import 'package:hive/hive.dart';

part 'course_model.g.dart';

@HiveType(typeId: 0)
class CourseModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;

  CourseModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] is String ? int.parse(json['id']) : (json['id'] ?? 0),
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
  };

  CourseModel copyWith({int? id, String? title, String? body}) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}