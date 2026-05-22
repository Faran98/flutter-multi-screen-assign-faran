import 'package:flutter/material.dart';
import '../controllers/course_controller.dart';
import '../models/course_model.dart';

class AddEditCourseScreen extends StatefulWidget {
  final CourseModel? course;

  const AddEditCourseScreen({super.key, this.course});

  @override
  State<AddEditCourseScreen> createState() => _AddEditCourseScreenState();
}

class _AddEditCourseScreenState extends State<AddEditCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _controller = CourseController();

  bool _isLoading = false;
  bool get _isEditing => widget.course != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _titleController.text = widget.course!.title;
      _bodyController.text = widget.course!.body;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      CourseModel result;

      if (_isEditing) {
        result = await _controller.updateCourse(
          widget.course!.id,
          _titleController.text.trim(),
          _bodyController.text.trim(),
        );
      } else {
        result = await _controller.addCourse(
          _titleController.text.trim(),
          _bodyController.text.trim(),
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing
                  ? 'Course updated successfully'
                  : 'Course added successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, result);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing ? 'Failed to update course' : 'Failed to add course',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      appBar: AppBar(
        backgroundColor: const Color(0xff1565c0),
        title: Text(
          _isEditing ? 'Edit Course' : 'Add Course',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 420,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
              ),

              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// HEADER ICON
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(
                              _isEditing ? Icons.edit : Icons.add_circle,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            _isEditing ? 'Update Course' : 'New Course',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _isEditing
                                ? 'Modify course details below'
                                : 'Fill in the course details',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// TITLE FIELD
                    const Text(
                      'Course Title',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _titleController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a course title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'e.g. Mobile App Development',
                        prefixIcon: const Icon(Icons.book),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// BODY / DESCRIPTION
                    const Text(
                      'Course Description',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _bodyController,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter course description...',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _isLoading ? null : _submit,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                _isEditing ? 'Update Course' : 'Add Course',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}