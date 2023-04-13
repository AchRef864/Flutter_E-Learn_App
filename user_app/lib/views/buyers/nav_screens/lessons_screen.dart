import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizz/views/buyers/nav_screens/course_screen.dart';
import 'package:quizz/views/buyers/nav_screens/lesson_screen.dart';

class LessonsPage extends StatefulWidget {
  final String courseId;

  const LessonsPage({Key? key, required this.courseId}) : super(key: key);

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  void _navigateToLesson(String courseId, String lessonId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LessonPage(courseId: courseId, lessonId: lessonId)),
    );
  }

  late Stream<QuerySnapshot> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .collection('lessons')
        .snapshots();
  }

  @override
  Future<String> getTitle(String courseId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['title'];
  }

  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _userStream,
          builder:
              ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('something wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("loading");
            }
            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        data['title'],
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      subtitle: Text(
                        data['codeline'],
                        style: TextStyle(
                          color: Color.fromARGB(255, 150, 150, 150),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text(
                            'START',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            _navigateToLesson(widget.courseId, document.id);
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}
