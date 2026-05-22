import '../models/course_model.dart';
import '../services/course_service.dart';

class CourseController {
  List<CourseModel> courses = [];

  Future<List<CourseModel>> fetchCourses() async {
    courses = await CourseService.getCourses();
    return courses;
  }

  Future<CourseModel> addCourse(String title, String body) async {
    final newCourse = await CourseService.addCourse(
      title: title,
      body: body,
    );
    courses.insert(0, newCourse);
    return newCourse;
  }

  Future<CourseModel> updateCourse(int id, String title, String body) async {
    final updated = await CourseService.updateCourse(
      id: id,
      title: title,
      body: body,
    );
    final index = courses.indexWhere((c) => c.id == id);
    if (index != -1) {
      courses[index] = updated;
    }
    return updated;
  }

  Future<void> deleteCourse(int id) async {
    await CourseService.deleteCourse(id);
    courses.removeWhere((c) => c.id == id);
  }
}