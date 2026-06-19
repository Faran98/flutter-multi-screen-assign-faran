import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

// Sahi package name ke sath imports
import 'package:flutter_multi_screen_assign_faran/main.dart';
import 'package:flutter_multi_screen_assign_faran/models/course_model.dart';
import 'package:flutter_multi_screen_assign_faran/services/course_service.dart';
import 'package:flutter_multi_screen_assign_faran/services/local_database.dart';
import 'package:flutter_multi_screen_assign_faran/repositories/course_repository.dart';
import 'package:flutter_multi_screen_assign_faran/controllers/course_controller.dart';

void main() {
  testWidgets('App initialization and login screen render test', (WidgetTester tester) async {
    // Hive initialize for testing scope
    await Hive.initFlutter();
    
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CourseModelAdapter());
    }
    
    await Hive.openBox<CourseModel>("offlineCoursesBox");

    final apiService = CourseService();
    final localDb = LocalDatabase();
    final courseRepository = CourseRepository(apiService: apiService, localDb: localDb);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CourseController(repository: courseRepository),
          ),
        ],
        child: const MyApp(),
      ),
    );

    // Initial check definitions
    expect(find.text('Create Account'), findsNothing); 
    expect(find.byType(Form), findsOneWidget); 
    
    final textFormFields = find.byType(TextFormField);
    expect(textFormFields, findsWidgets); 
  });
}