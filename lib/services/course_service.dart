import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course_model.dart';

class CourseService {
  static const String _baseUrl =
      'https://jsonplaceholder.typicode.com/posts';

  /// READ - GET all courses
  static Future<List<CourseModel>> getCourses() async {
    final response = await http.get(Uri.parse('$_baseUrl?_limit=10'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CourseModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  /// CREATE - POST new course
  static Future<CourseModel> addCourse({
    required String title,
    required String body,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': 1,
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 201) {
      return CourseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add course');
    }
  }

  /// UPDATE - PUT existing course
  static Future<CourseModel> updateCourse({
    required int id,
    required String title,
    required String body,
  }) async {
    // JSONPlaceholder only has IDs 1-100
    // If ID > 100 (locally added post), use ID 1 as fallback
    final validId = id <= 100 ? id : 1;

    final response = await http.put(
      Uri.parse('$_baseUrl/$validId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': validId,
        'userId': 1,
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      // Return with original ID so UI updates correctly
      return CourseModel(
        id: id,
        userId: 1,
        title: title,
        body: body,
      );
    } else {
      throw Exception('Failed to update course');
    }
  }

  /// DELETE - DELETE course
  static Future<void> deleteCourse(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete course');
    }
  }

} // ← closing brace of class