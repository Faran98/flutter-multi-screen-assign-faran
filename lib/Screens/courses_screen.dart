import 'package:flutter/material.dart';
import '../controllers/course_controller.dart';
import '../models/course_model.dart';
import '../widgets/course_card.dart';
import 'add_edit_course_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final CourseController _controller = CourseController();

  bool _isLoading = true;
  String? _errorMessage;
  List<CourseModel> _courses = [];

  final List<String> englishTitles = [
    'Mobile App Development',
    'Software Re-engineering',
    'Database Management Systems',
    'Object Oriented Programming',
    'Web Technologies',
    'Computer Networks',
    'Operating Systems',
    'Software Engineering',
    'Artificial Intelligence',
    'Data Structures & Algorithms',
  ];

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final courses = await _controller.fetchCourses();

      final remapped = courses.asMap().entries.map((entry) {
        final i = entry.key;
        final course = entry.value;
        return course.copyWith(
          title: i < englishTitles.length ? englishTitles[i] : course.title,
        );
      }).toList();

      setState(() {
        _courses = remapped;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load courses. Please try again.';
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteCourse(CourseModel course) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Delete Course'),
        content: Text(
          'Are you sure you want to delete "${course.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _controller.deleteCourse(course.id);
        setState(() {
          _courses.removeWhere((c) => c.id == course.id);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Course deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to delete course'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _openAddCourse() async {
    final result = await Navigator.push<CourseModel>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddEditCourseScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        _courses.insert(0, result);
      });
    }
  }

  void _openEditCourse(CourseModel course) async {
    final result = await Navigator.push<CourseModel>(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditCourseScreen(course: course),
      ),
    );

    if (result != null) {
      setState(() {
        final index = _courses.indexWhere((c) => c.id == result.id);
        if (index != -1) _courses[index] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      appBar: AppBar(
        backgroundColor: const Color(0xff1565c0),
        title: const Text(
          'API Courses',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _fetchCourses,
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff1565c0),
        onPressed: _openAddCourse,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Course',
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: _buildBody(),
    );
  }

  Widget _buildBody() {

    /// LOADING STATE
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xff1565c0)),
            SizedBox(height: 16),
            Text(
              'Fetching courses...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    /// ERROR STATE
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1565c0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _fetchCourses,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text(
                  'Retry',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    /// SUCCESS STATE
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListView.builder(
        itemCount: _courses.length,
        itemBuilder: (context, index) {
          final course = _courses[index];
          return CourseCard(
            course: course,
            onEdit: () => _openEditCourse(course),
            onDelete: () => _deleteCourse(course),
            onTap: () => _showCourseDetail(course),
          );
        },
      ),
    );
  }

  void _showCourseDetail(CourseModel course) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// DRAG HANDLE
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              course.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Course ID: ${course.id}',
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 12),

            Text(
              course.body,
              style: const TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}