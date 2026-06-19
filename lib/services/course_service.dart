import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course_model.dart';

class CourseService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<CourseModel>> fetchCourses() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      // Assignment requirements ke mutabik top 10 items extract karte hain
      return data.take(10).map((json) => CourseModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load courses from remote API");
    }
  }

  Future<CourseModel> addCourse(String title, String body) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: jsonEncode({"title": title, "body": body, "userId": 1}),
    );
    if (response.statusCode == 201) {
      return CourseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to create remote data instance");
    }
  }

  Future<CourseModel> updateCourse(int id, String title, String body) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: jsonEncode({"id": id, "title": title, "body": body, "userId": 1}),
    );
    if (response.statusCode == 200) {
      return CourseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update remote data structure");
    }
  }

  Future<void> deleteCourse(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to perform remote target erasure");
    }
  }
}