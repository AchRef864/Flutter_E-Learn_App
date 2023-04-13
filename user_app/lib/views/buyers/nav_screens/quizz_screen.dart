import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizz/views/buyers/main_screen.dart';

class QuizzPage extends StatefulWidget {
  final String courseId;
  final String lessonId;
  final String quizzId;
  const QuizzPage(
      {Key? key,
      required this.courseId,
      required this.lessonId,
      required this.quizzId})
      : super(key: key);

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  bool? selectedOption;
  Future<String> getQuestion(
      String courseId, String lessonId, String quizzId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('lessons')
        .doc(lessonId)
        .collection('quizz')
        .doc(quizzId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['question'];
  }

  Future<Map> getQuizz(String courseId, String lessonId, String quizzId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('lessons')
        .doc(lessonId)
        .collection('quizz')
        .doc(quizzId)
        .get();
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['options'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: getQuestion(widget.courseId, widget.lessonId, widget.quizzId),
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
                      future: getQuestion(
                          widget.courseId, widget.lessonId, widget.quizzId),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            '${snapshot.data!}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 42, 42),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<Map>(
                future:
                    getQuizz(widget.courseId, widget.lessonId, widget.quizzId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final options = snapshot.data!;
                  return Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors
                          .white, // set the color of the checkbox when it is not selected
                    ),
                    child: Column(
                      children: options.entries.map((entry) {
                        final option = entry.key;
                        bool? value = options[
                            option]; // set the value to the corresponding option value
                        return CheckboxListTile(
                          title: Text(
                            option,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          value: value,
                          onChanged: (newValue) {
                            setState(() {
                              options[option] = newValue!;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Congratulations!"),
                          content: Text("You have completed the lesson."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()),
                                );
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(Icons.check_rounded),
                  style: ElevatedButton.styleFrom(
                    primary:
                        Color.fromARGB(255, 137, 211, 73), // Light green color
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
    );
  }
}
