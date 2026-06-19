import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/course_service.dart';
import '../services/local_database.dart';
import '../models/course_model.dart';

class CourseRepository {
  final CourseService apiService;
  final LocalDatabase localDb;

  // English courses ki clean list static mapping ke liye
  final List<Map<String, String>> _englishCoursesData = [
    {"title": "Mobile Application Development", "body": "Master cross-platform mobile development using Google's Flutter framework, Dart language, and clean architecture implementation layers."},
    {"title": "Software Re-engineering", "body": "Learn the methodology of program restructuring, legacy system analysis, reverse engineering patterns, and code architecture refactoring."},
    {"title": "Management Information Systems (MIS)", "body": "Explore enterprise resource planning systems, business data intelligence networks, database modeling, and technical decision architectures."},
    {"title": "Artificial Intelligence & Agent Systems", "body": "Dive into deep neural networks, predictive data analytics, automated orchestration engines, and real-time inference models."},
    {"title": "Cloud Computing Infrastructure", "body": "Build serverless microservices pipelines, secure storage boxes, cloud integration models, and optimized automated resource deployment frameworks."},
    {"title": "Advanced Web Engineering (MERN)", "body": "Design high-performance world-class SaaS enterprise frameworks utilizing complete end-to-end Mongo, Express, React, and Node stack systems."},
    {"title": "Human-Computer Interaction", "body": "Analyze UX research metrics, user persona parameters, empirical usability heuristics surveys, and UI mockup prototype evaluation models."},
    {"title": "Information Security Systems", "body": "Study cryptographic payload generation systems, authorization security protocols, firewall architectures, and vulnerability mapping layers."},
    {"title": "Data Warehousing & Analytics", "body": "Understand large-scale data ingestion architectures, extraction transformation pipelines, and relational reporting repository engines."},
    {"title": "Software Project Management", "body": "Coordinate agile development execution timelines, gantt chart resource allocations, matrix lifecycle task tracking, and milestone delivery parameters."},
  ];

  CourseRepository({required this.apiService, required this.localDb});

  Future<List<CourseModel>> getCourses() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final remoteCourses = await apiService.fetchCourses();
        
        // Latin data ko permanent English data se overwrite/map karne ka logic
        List<CourseModel> cleanEnglishCourses = [];
        for (int i = 0; i < remoteCourses.length; i++) {
          if (i < _englishCoursesData.length) {
            cleanEnglishCourses.add(
              CourseModel(
                id: remoteCourses[i].id,
                title: _englishCoursesData[i]["title"]!,
                body: _englishCoursesData[i]["body"]!,
              ),
            );
          } else {
            cleanEnglishCourses.add(remoteCourses[i]);
          }
        }

        // Clean English data ko hi cache me aur UI par bheinjein
        await localDb.cacheCourses(cleanEnglishCourses);
        return cleanEnglishCourses;
      } catch (_) {
        return localDb.getCachedCourses();
      }
    } else {
      return localDb.getCachedCourses();
    }
  }

  Future<CourseModel> addCourse(String title, String body) async {
    return await apiService.addCourse(title, body);
  }

  Future<CourseModel> updateCourse(int id, String title, String body) async {
    return await apiService.updateCourse(id, title, body);
  }

  Future<void> deleteCourse(int id) async {
    await apiService.deleteCourse(id);
  }
}