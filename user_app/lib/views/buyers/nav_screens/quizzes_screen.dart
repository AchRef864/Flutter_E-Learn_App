import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizz/views/buyers/nav_screens/quizz_screen.dart';

class QuizzesPage extends StatefulWidget {
  final String courseId;
  final String lessonId;

  const QuizzesPage({Key? key, required this.courseId, required this.lessonId})
      : super(key: key);
  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  void _navigateToQuizz(String courseId, String lessonId, String QuizzId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => QuizzPage(
              courseId: courseId, lessonId: lessonId, quizzId: QuizzId)),
    );
  }

  late Stream<QuerySnapshot> _userStream;
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .collection('lessons')
        .doc(widget.lessonId)
        .collection('quizz')
        .snapshots();
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
                        data['question'],
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
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
                            _navigateToQuizz(
                                widget.courseId, widget.lessonId, document.id);
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
