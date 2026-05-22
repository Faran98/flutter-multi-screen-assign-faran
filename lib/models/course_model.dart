class CourseModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  CourseModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  CourseModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
  }) {
    return CourseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}