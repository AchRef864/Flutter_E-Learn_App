import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:quizz/views/buyers/nav_screens/lessons_screen.dart';

class CoursePage extends StatefulWidget {
  final String courseId;

  const CoursePage({Key? key, required this.courseId}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  void _navigateToLesson() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LessonsPage(courseId: widget.courseId)),
    );
  }

  final Stream<QuerySnapshot> _userStream =
      FirebaseFirestore.instance.collection('courses').snapshots();

  Future<String> getTitle(String courseId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['title'];
  }

  Future<String> getInroduction(String courseId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['introduction'];
  }

  Future<String> getAuthor(String courseId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['author'];
  }

  Future<Timestamp> getDate(String courseId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['date'];
  }

  @override
  Widget build(BuildContext context) {
    // Add your widget tree for the course page here
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: getTitle(widget.courseId),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('Loading...');
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<String>(
                      future: getTitle(widget.courseId),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            'Weclome To ${snapshot.data!} !!!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 124, 61, 61),
                              fontSize: 28,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text('Loading...');
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Introduction: \n\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 48, 58, 94),
                              fontSize: 23,
                            ),
                          ),
                        ),
                        FutureBuilder<String>(
                          future: getInroduction(widget.courseId),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 45, 62, 122),
                                  fontSize: 20,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text('Loading...');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<String>(
                      future: getAuthor(widget.courseId),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text('Loading...');
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<Timestamp>(
                      future: getDate(widget.courseId),
                      builder: (BuildContext context,
                          AsyncSnapshot<Timestamp> snapshot) {
                        if (snapshot.hasData) {
                          final date = snapshot.data!
                              .toDate(); // Convert Timestamp to DateTime
                          final formattedDate = DateFormat.yMMMMd()
                              .format(date); // Format DateTime as a String
                          return Text(
                            formattedDate,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text('Loading...');
                        }
                      },
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _navigateToLesson();
                        },
                        child: Text('Start'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(
                              255, 137, 211, 73), // Light green color
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'courier',
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
