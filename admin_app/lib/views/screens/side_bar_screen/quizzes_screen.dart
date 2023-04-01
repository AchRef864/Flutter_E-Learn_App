import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QuizzesScreen extends StatefulWidget {
  static const String routeName = '\QuizzesScreen';

  @override
  _QuizzesScreenState createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _option1 = TextEditingController();
  TextEditingController _option2 = TextEditingController();
  TextEditingController _option3 = TextEditingController();
  final List<String> coursesNames = [];
  String? SelectedCourse;
  final List<String> lessonsNames = [];
  String? SelectedLesson;
  String? _textFieldValue;
  String _option1Value = '';
  String _option2Value = '';
  String _option3Value = '';
  bool q1 = false;
  bool q2 = false;
  bool q3 = false;

  uploadToFirebaseStore() async {
    EasyLoading.show(status: 'Uploading ...');
    if ((!_textFieldController.text.isEmpty) &&
        (!_option1.text.isEmpty) &&
        (!_option2.text.isEmpty) &&
        (!_option3.text.isEmpty) &&
        (SelectedCourse != null) &&
        (SelectedLesson != null)) {
      _textFieldValue = await _textFieldController.text;
      _option1Value = _option1.text;
      _option2Value = _option2.text;
      _option3Value = _option3.text;
      Map<String, dynamic> myDictionary = {
        _option1Value: q1,
        _option2Value: q2,
        _option3Value: q3,
      };
      await _firestore
          .collection("courses")
          .doc(SelectedCourse)
          .collection('lessons')
          .doc(SelectedLesson)
          .collection('quizz')
          .doc(SelectedLesson)
          .set({
        'question': _textFieldValue,
        'options': myDictionary,
        'date': DateTime.now(),
      }).whenComplete(() {
        EasyLoading.showSuccess('Great Success!');
        setState(() {
          SelectedCourse = null;
          SelectedLesson = null;
          _textFieldController.clear();
          _option1.clear();
          _option2.clear();
          _option3.clear();
          q1 = false;
          q2 = false;
          q3 = false;
        });
      });
    } else {
      EasyLoading.showError('Failed with Error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Warning"),
            content: Text("You should pick an image and a title"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Courses',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
        ),
        Divider(
          color: Colors.white,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Add this line
                children: [
                  Text(
                    'Course:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('courses')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return DropdownButton<String>(
                          items: [],
                          onChanged: null,
                        );
                      }
                      List<String> coursesNames = [];
                      for (final documentSnapshot in snapshot.data!.docs) {
                        final documentName = documentSnapshot.id;
                        coursesNames.add(documentName);
                      }
                      return DropdownButton<String>(
                        value: SelectedCourse,
                        dropdownColor: Colors.black,
                        items: coursesNames
                            .map((courseName) => DropdownMenuItem(
                                  value: courseName,
                                  child: Text(
                                    courseName,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (courseName) =>
                            setState(() => SelectedCourse = courseName),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Add this line
                children: [
                  Text(
                    'Lesson:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('courses')
                        .doc(SelectedCourse)
                        .collection('lessons')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return DropdownButton<String>(
                          items: [],
                          onChanged: null,
                        );
                      }
                      List<String> lessonsNames = [];
                      for (final documentSnapshot in snapshot.data!.docs) {
                        final documentName = documentSnapshot.id;
                        lessonsNames.add(documentName);
                      }
                      return DropdownButton<String>(
                        value: SelectedLesson,
                        dropdownColor: Colors.black,
                        items: lessonsNames
                            .map((courseName) => DropdownMenuItem(
                                  value: courseName,
                                  child: Text(
                                    courseName,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (courseName) =>
                            setState(() => SelectedLesson = courseName),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Add this line
                children: [
                  Text(
                    'Question:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: 500,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter question here',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      controller: _textFieldController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Add this line
                children: [
                  Text(
                    'Options:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: 600,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: 50,
                            decoration: InputDecoration(
                              hintText: 'Enter title here',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            controller: _option1,
                          ),
                        ),
                        Checkbox(
                          value: q1,
                          onChanged: (value) {
                            setState(() {
                              q1 = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 600,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: 50,
                            decoration: InputDecoration(
                              hintText: 'Enter title here',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            controller: _option2,
                          ),
                        ),
                        Checkbox(
                          value: q2,
                          onChanged: (value) {
                            setState(() {
                              q2 = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 600,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: 50,
                            decoration: InputDecoration(
                              hintText: 'Enter title here',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            controller: _option3,
                          ),
                        ),
                        Checkbox(
                          value: q3,
                          onChanged: (value) {
                            setState(() {
                              q3 = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: SizedBox(
                width: 150,
                height: 50, // set desired width here
                child: ElevatedButton(
                  onPressed: () {
                    uploadToFirebaseStore();
                  },
                  child: Text(
                    'Add Quizz',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
