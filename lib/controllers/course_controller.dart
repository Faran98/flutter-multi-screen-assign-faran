import 'package:flutter/material.dart';
import '../repositories/course_repository.dart';
import '../models/course_model.dart';
import '../enums/auth_state_enum.dart';

class CourseController extends ChangeNotifier {
  final CourseRepository repository;

  CourseController({required this.repository});

  List<CourseModel> _allCourses = [];
  List<CourseModel> _filteredCourses = [];
  CourseState _state = CourseState.loading;
  String _errorMessage = '';
  String _searchQuery = '';

  List<CourseModel> get courses => _filteredCourses; // UI hamesha filtered courses dekhega
  CourseState get state => _state;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  Future<void> loadCourses() async {
    _state = CourseState.loading;
    notifyListeners();
    try {
      _allCourses = await repository.getCourses();
      _applyFilter();
    } catch (e) {
      _errorMessage = e.toString();
      _state = CourseState.error;
    }
    notifyListeners();
  }

  // Real-time Search Filter Logic
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredCourses = List.from(_allCourses);
    } else {
      _filteredCourses = _allCourses
          .where((course) =>
              course.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              course.body.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    if (_allCourses.isEmpty) {
      _state = CourseState.empty;
    } else if (_filteredCourses.isEmpty && _searchQuery.isNotEmpty) {
      _state = CourseState.empty; // Search result empty hone ka state
    } else {
      _state = CourseState.success;
    }
  }

  Future<void> addNewCourse(String title, String body) async {
    try {
      final newCourse = await repository.addCourse(title, body);
      _allCourses.insert(0, newCourse);
      _applyFilter();
      await repository.localDb.saveSingleCourse(newCourse);
    } catch (e) {
      throw Exception("Failed to save remote course.");
    }
  }

  Future<void> removeCourse(int id) async {
    final originalCopy = List<CourseModel>.from(_allCourses);
    _allCourses.removeWhere((item) => item.id == id);
    _applyFilter();
    notifyListeners();

    try {
      await repository.deleteCourse(id);
      await repository.localDb.deleteSingleCourse(id);
    } catch (e) {
      _allCourses = originalCopy;
      _applyFilter();
      notifyListeners();
      throw Exception("Operation failed. UI rollback executed.");
    }
  }

  Future<void> modifyCourse(int id, String title, String body) async {
    final originalCopy = List<CourseModel>.from(_allCourses);
    final index = _allCourses.indexWhere((element) => element.id == id);
    
    if (index != -1) {
      _allCourses[index] = _allCourses[index].copyWith(title: title, body: body);
      _applyFilter();
      notifyListeners();
    }

    try {
      final updatedCourse = await repository.updateCourse(id, title, body);
      await repository.localDb.saveSingleCourse(updatedCourse);
    } catch (e) {
      _allCourses = originalCopy;
      _applyFilter();
      notifyListeners();
      throw Exception("Operation failed. UI rollback executed.");
    }
  }
}