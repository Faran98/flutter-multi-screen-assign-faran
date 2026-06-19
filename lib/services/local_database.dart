import 'package:hive_flutter/hive_flutter.dart';
import '../models/course_model.dart';

class LocalDatabase {
  static const String _boxName = "offlineCoursesBox";

  Future<void> cacheCourses(List<CourseModel> courses) async {
    final box = Hive.box<CourseModel>(_boxName);
    await box.clear();
    await box.addAll(courses);
  }

  List<CourseModel> getCachedCourses() {
    final box = Hive.box<CourseModel>(_boxName);
    return box.values.toList();
  }

  Future<void> saveSingleCourse(CourseModel course) async {
    final box = Hive.box<CourseModel>(_boxName);
    await box.put(course.id, course);
  }

  Future<void> deleteSingleCourse(int id) async {
    final box = Hive.box<CourseModel>(_boxName);
    await box.delete(id);
  }
}