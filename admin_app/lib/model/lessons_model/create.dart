import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class create extends StatefulWidget {
  static const String routeName = '\SubscriptionsScreen';

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textAreaController = TextEditingController();
  TextEditingController _codeAreaController = TextEditingController();
  final List<String> coursesNames = [];
  String? SelectedCourse;
  String? _textFieldValue;
  String? _textAreaValue;
  String? _codeAreaValue;

  uploadToFirebaseStore() async {
    EasyLoading.show(status: 'Uploading ...');
    if ((!_textFieldController.text.isEmpty) &&
        (!_textAreaController.text.isEmpty) &&
        (SelectedCourse != null)) {
      _textFieldValue = await _textFieldController.text;
      _textAreaValue = await _textAreaController.text;
      _codeAreaValue = await _codeAreaController.text;
      await _firestore
          .collection("courses")
          .doc(SelectedCourse)
          .collection('lessons')
          .doc(_textFieldValue)
          .set({
        'title': _textFieldValue,
        'lesson': _textAreaValue,
        'codeline': _codeAreaValue,
        'date': DateTime.now(),
      }).whenComplete(() {
        EasyLoading.showSuccess('Great Success!');
        setState(() {
          _textFieldController.clear();
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
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Lessons',
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
                      'Title:',
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
                      'Add Lesson',
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
