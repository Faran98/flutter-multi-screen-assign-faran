import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/course_model.dart';
import 'services/course_service.dart';
import 'services/local_database.dart';
import 'repositories/course_repository.dart';
import 'controllers/course_controller.dart';
import 'Screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Storage Framework Optimization Nodes
  await Hive.initFlutter();
  Hive.registerAdapter(CourseModelAdapter());
  await Hive.openBox<CourseModel>("offlineCoursesBox");

  // Structural Dependency Wireframe Pipeline
  final apiService = CourseService();
  final localDb = LocalDatabase();
  final courseRepository = CourseRepository(apiService: apiService, localDb: localDb);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CourseController(repository: courseRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Structured Portal Solution',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}