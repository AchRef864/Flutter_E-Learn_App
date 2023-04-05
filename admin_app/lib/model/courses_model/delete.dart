import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class delete extends StatefulWidget {
  static const String routeName = '\CoursesScreen';

  @override
  State<delete> createState() => _deleteState();
}

class _deleteState extends State<delete> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? fileName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedLanguage;
  String? SelectedCourse;

  uploadToFirebaseStore() async {
    EasyLoading.show(status: 'Deleted ...');
    if (SelectedCourse != null) {
      String? choix = SelectedCourse;
      SelectedCourse = null;
      await _firestore
          .collection("courses")
          .doc(choix)
          .delete()
          .whenComplete(() {
        EasyLoading.showSuccess('Data Deleted!');
        setState(() {});
      });
    } else {
      EasyLoading.showError('Failed with Error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Warning"),
            content: Text("Fill required fields"),
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
    return Center(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Add this line
                    children: [
                      Text(
                        'Course to be deleted:',
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
                              onChanged: (courseName) async {
                                setState(() => SelectedCourse = courseName);
                              });
                        },
                      ),
                    ],
                  ),
                ),
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
                        'Delete Course',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
