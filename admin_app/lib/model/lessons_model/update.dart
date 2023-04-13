import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class update extends StatefulWidget {
  static const String routeName = '\SubscriptionsScreen';

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _newTitleController = TextEditingController();
  TextEditingController _textAreaController = TextEditingController();
  TextEditingController _codeAreaController = TextEditingController();
  final List<String> coursesNames = [];
  String? SelectedCourse;
  String? SelectedLesson;
  String? _textFieldValue;
  String? _textAreaValue;
  String? _codeAreaValue;

  getLessonDetails() async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('courses')
        .doc(SelectedCourse)
        .collection('lessons')
        .doc(SelectedLesson);
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      setState(() {
        _newTitleController.text =
            (doc.data() as Map<String, dynamic>)['title'];
        _codeAreaController.text =
            (doc.data() as Map<String, dynamic>)['codeline'];
        _textAreaController.text =
            (doc.data() as Map<String, dynamic>)['lesson'];
      });
    }
  }

  uploadToFirebaseStore() async {
    EasyLoading.show(status: 'Uploading ...');
    if ((!_newTitleController.text.isEmpty) &&
        (!_textAreaController.text.isEmpty) &&
        (SelectedCourse != null)) {
      _textFieldValue = await _newTitleController.text;
      _textAreaValue = await _textAreaController.text;
      _codeAreaValue = await _codeAreaController.text;
      await _firestore
          .collection("courses")
          .doc(SelectedCourse)
          .collection('lessons')
          .doc(SelectedLesson)
          .update({
        'title': _textFieldValue,
        'lesson': _textAreaValue,
        'codeline': _codeAreaValue,
        'date': DateTime.now(),
      }).whenComplete(() {
        EasyLoading.showSuccess('Great Success!');
        setState(() {
          _newTitleController.clear();
          _textAreaController.clear();
          SelectedCourse = null;
        });
      });
    } else {
      EasyLoading.showError('Failed with Error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Warning"),
            content: Text("You fill all data"),
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
    return SingleChildScrollView(
      child: Column(
        children: [
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
                          final document1Name = documentSnapshot.id;
                          coursesNames.add(document1Name);
                        }
                        return DropdownButton<String>(
                          value: SelectedCourse,
                          dropdownColor: Colors.black,
                          items: coursesNames
                              .map((lessonName) => DropdownMenuItem(
                                    value: lessonName,
                                    child: Text(
                                      lessonName,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (lessonName) => setState(() {
                            SelectedCourse = lessonName;
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: SelectedCourse != null,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Add this line
                    children: [
                      Column(
                        children: [
                          Row(
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
                                  for (final documentSnapshot
                                      in snapshot.data!.docs) {
                                    final document2Name = documentSnapshot.id;
                                    lessonsNames.add(document2Name);
                                  }
                                  return DropdownButton<String>(
                                    value: SelectedLesson,
                                    dropdownColor: Colors.black,
                                    items: lessonsNames
                                        .map((lessonName) => DropdownMenuItem(
                                              value: lessonName,
                                              child: Text(
                                                lessonName,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (lessonName) => setState(() {
                                      SelectedLesson = lessonName;
                                      getLessonDetails();
                                    }),
                                  );
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'New Title:',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 50,
                                width: 200,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter title here',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  controller: _newTitleController,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      'Lesson:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 400,
                      width: 600,
                      child: TextField(
                        maxLines: 50,
                        decoration: InputDecoration(
                          hintText: 'Write lesson here',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: _textAreaController,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 600,
                      child: TextField(
                        maxLines: 50,
                        decoration: InputDecoration(
                          hintText: 'Write code here',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.black,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: _codeAreaController,
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
                      'Update Lesson',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
