import 'package:flutter/material.dart';

class DetailScreen
    extends StatelessWidget {

  final String subjectName;

  const DetailScreen({
    super.key,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xfff5f5f5),

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(subjectName),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            /// BANNER
            Container(
              height: 180,
              width: double.infinity,

              decoration:
                  const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.lightBlue,
                  ],
                ),
              ),

              child: const Center(
                child: Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    subjectName,

                    style:
                        const TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// DESCRIPTION
                  Container(
                    padding:
                        const EdgeInsets.all(
                            16),

                    decoration:
                        BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              15),
                    ),

                    child: const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(
                          "Course Overview",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight
                                    .bold,
                            color:
                                Colors.blue,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          "This course provides complete knowledge related to software development, system design, practical implementation, and modern technologies used in the industry.",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// SCHEDULE
                  Container(
                    padding:
                        const EdgeInsets.all(
                            16),

                    decoration:
                        BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              15),
                    ),

                    child: const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(
                          "Schedule Details",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight
                                    .bold,
                            color:
                                Colors.blue,
                          ),
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [

                            Icon(Icons
                                .calendar_today),

                            SizedBox(width: 10),

                            Text(
                              "Monday & Wednesday",
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [

                            Icon(Icons
                                .access_time),

                            SizedBox(width: 10),

                            Text(
                              "10:00 AM - 11:30 AM",
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [

                            Icon(Icons.room),

                            SizedBox(width: 10),

                            Text(
                              "CS Lab 3",
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}