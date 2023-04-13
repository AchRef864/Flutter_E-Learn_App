import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:quizz/views/buyers/nav_screens/quizzes_screen.dart';

class LessonPage extends StatefulWidget {
  final String courseId;
  final String lessonId;
  const LessonPage({Key? key, required this.courseId, required this.lessonId})
      : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  void _navigateToLesson() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => QuizzesPage(
              courseId: widget.courseId, lessonId: widget.lessonId)),
    );
  }

  Future<String> getTitle(String courseId, String lessonId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('lessons')
        .doc(lessonId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['title'];
  }

  Future<String> getLesson(String courseId, String lessonId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('lessons')
        .doc(lessonId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['lesson'];
  }

  Future<String> getcodline(String courseId, String lessonId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('lessons')
        .doc(lessonId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['codeline'];
  }

  Future<Timestamp> getDate(String courseId, String lessonId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('lessons')
        .doc(lessonId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['date'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: getTitle(widget.courseId, widget.lessonId),
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
                      future: getTitle(widget.courseId, widget.lessonId),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            '${snapshot.data!}',
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
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 201, 201, 201),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Lesson : \n\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          FutureBuilder<String>(
                            future: getLesson(widget.courseId, widget.lessonId),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<String>(
                        future: getcodline(widget.courseId, widget.lessonId),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white, // set text color to white
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<Timestamp>(
                      future: getDate(widget.courseId, widget.lessonId),
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
                        child: Text('QUICK TEST!!!'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(
                              255, 211, 73, 73), // Light green color
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
