import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'detail_screen.dart';
import 'login_screen.dart';
import 'courses_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String userName;

  DashboardScreen({
    super.key,
    required this.userName,
  });

  final List<Map<String, dynamic>> subjects = [
    {
      "title": "Mobile App Development",
      "subtitle": "Flutter • Android • iOS",
      "icon": Icons.phone_android,
      "color": Colors.blue,
    },
    {
      "title": "Software Re-engineering",
      "subtitle": "Refactoring • Legacy Systems",
      "icon": Icons.build,
      "color": Colors.purple,
    },
    {
      "title": "Management Information Systems",
      "subtitle": "MIS • ERP • Analytics",
      "icon": Icons.bar_chart,
      "color": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      body: SafeArea(
        child: Column(
          children: [

            /// TOP HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff1565c0),
                    Color(0xff1976d2),
                  ],
                ),
              ),
              child: Row(
                children: [

                  /// AVATAR
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: Text(
                      userName.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// USER INFO
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Student • Online",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// LOGOUT
                  IconButton(
                    onPressed: () async {
                      await AuthService.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            /// SECTION: MY SUBJECTS
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My Subjects",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            /// SUBJECT LIST
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    const SizedBox(height: 16),

                    ...subjects.asMap().entries.map((entry) {
                      final subject = entry.value;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                            )
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: subject["color"].withOpacity(0.15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              subject["icon"],
                              color: subject["color"],
                              size: 30,
                            ),
                          ),
                          title: Text(
                            subject["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              subject["subtitle"],
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailScreen(
                                  subjectName: subject["title"],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),

                    /// API COURSES CARD
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff1565c0), Color(0xff1976d2)],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.cloud_download,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        title: const Text(
                          'API Courses',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            'JSONPlaceholder • REST API • CRUD',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CoursesScreen(),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}