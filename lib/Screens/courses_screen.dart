import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/course_controller.dart';
import '../enums/auth_state_enum.dart';
import '../models/course_model.dart';
import '../widgets/course_card.dart';
import 'add_edit_course_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CourseController>().loadCourses());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CourseController>();

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: const Color(0xff1565c0),
        title: const Text('API Courses', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _searchController.clear();
              controller.setSearchQuery('');
              controller.loadCourses();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff1565c0),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditCourseScreen()),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Course', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // 1. IMPROVEMENT: Integrated Real-time Search Input Field Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => controller.setSearchQuery(value),
              decoration: InputDecoration(
                hintText: 'Search courses by title or details...',
                prefixIcon: const Icon(Icons.search, color: Color(0xff1565c0)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          controller.setSearchQuery('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _searchController.clear();
                controller.setSearchQuery('');
                await controller.loadCourses();
              },
              child: _buildBody(controller),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(CourseController controller) {
    // 2. IMPROVEMENT: Replaced raw loading spinners with a Skeleton Loader UI layout
    if (controller.state == CourseState.loading) {
      return ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 140, height: 14, color: Colors.grey[200]),
                      const SizedBox(height: 8),
                      Container(width: 200, height: 10, color: Colors.grey[100]),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    /// ERROR STATE
    if (controller.state == CourseState.error) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text(controller.errorMessage, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1565c0)),
                onPressed: () => controller.loadCourses(),
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text('Retry', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }

    // 3. IMPROVEMENT: Context-aware Proper Empty State UI
    if (controller.state == CourseState.empty) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                controller.searchQuery.isNotEmpty ? Icons.search_off : Icons.folder_open,
                color: Colors.grey,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                controller.searchQuery.isNotEmpty
                    ? 'No courses found matching "${controller.searchQuery}"'
                    : 'No course nodes available in data array.',
                style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text('Pull down down to refresh or check system indexes.', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      );
    }

    /// SUCCESS STATE
    return ListView.builder(
      itemCount: controller.courses.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final course = controller.courses[index];
        return CourseCard(
          course: course,
          onEdit: () => _openEditCourse(course),
          onDelete: () => _deleteCourse(context, controller, course),
          onTap: () => _showCourseDetail(course),
        );
      },
    );
  }

  // (Baaqi _deleteCourse aur _showCourseDetail functions same pehle wale hi rahenge)
  Future<void> _deleteCourse(BuildContext context, CourseController controller, CourseModel course) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Course'),
        content: Text('Are you sure you want to delete "${course.title}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await controller.removeCourse(course.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Course deleted successfully'), backgroundColor: Colors.green));
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().replaceAll('Exception: ', '')), backgroundColor: Colors.red));
        }
      }
    }
  }

  void _openEditCourse(CourseModel course) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditCourseScreen(course: course)));
  }

  void _showCourseDetail(CourseModel course) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text(course.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Course ID: ${course.id}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Text(course.body, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}