import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class update extends StatefulWidget {
  static const String routeName = '\CoursesScreen';

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  dynamic _image;
  String? fileName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _newTitleController = TextEditingController();
  TextEditingController _authorNameController = TextEditingController();
  TextEditingController _textAreaController = TextEditingController();
  List<String> LanguageTypes = [
    'IOS developement',
    'DeskTop developement',
    'Web development',
    'Android developement',
    'Game development',
  ];
  String? selectedLanguage;
  String? _textFieldValue;
  String? _authorNameValue;
  String? _newTitleValue;
  String? SelectedCourse;
  String imageUrl = '';

  getCourseDetails() async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('courses').doc(SelectedCourse);

    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      setState(() {
        _newTitleController.text =
            (doc.data() as Map<String, dynamic>)['title'];
        _authorNameController.text =
            (doc.data() as Map<String, dynamic>)['author'];
        _textAreaController.text =
            (doc.data() as Map<String, dynamic>)['introduction'];
        selectedLanguage = (doc.data() as Map<String, dynamic>)['language'];
      });
    }
  }

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  _uploadToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('Courses').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadToFirebaseStore() async {
    EasyLoading.show(status: 'Updating ...');

    if ((SelectedCourse != null) &&
        (_image != null ||
            !_newTitleController.text.isEmpty ||
            !_textAreaController.text.isEmpty ||
            !_authorNameController.text.isEmpty ||
            selectedLanguage != null)) {
      if (_image != null) {
        String imageUrl = await _uploadToStorage(_image);
        await _firestore.collection("courses").doc(SelectedCourse).update({
          'image': imageUrl,
          'date': DateTime.now(),
        }).whenComplete(() {
          EasyLoading.showSuccess('Data Updated!');
          setState(() {
            _image = null;
          });
        });
      }
      if (!_newTitleController.text.isEmpty) {
        await _firestore.collection("courses").doc(SelectedCourse).update({
          'title': _newTitleController.text,
          'date': DateTime.now(),
        }).whenComplete(() {
          EasyLoading.showSuccess('Data Updated!');
          setState(() {
            _newTitleController.clear();
          });
        });
      }
      if (!_textAreaController.text.isEmpty) {
        await _firestore.collection("courses").doc(SelectedCourse).update({
          'introduction': _textAreaController.text,
          'date': DateTime.now(),
        }).whenComplete(() {
          EasyLoading.showSuccess('Data Updated!');
          setState(() {
            _textAreaController.clear();
          });
        });
      }
      if (!_authorNameController.text.isEmpty) {
        await _firestore.collection("courses").doc(SelectedCourse).update({
          'author': _authorNameController.text,
          'date': DateTime.now(),
        }).whenComplete(() {
          EasyLoading.showSuccess('Data Updated!');
          setState(() {
            _authorNameController.clear();
          });
        });
      }
      if (selectedLanguage != null) {
        await _firestore.collection("courses").doc(SelectedCourse).update({
          'language': selectedLanguage,
          'date': DateTime.now(),
        }).whenComplete(() {
          EasyLoading.showSuccess('Data Updated!');
          setState(() {
            _authorNameController.clear();
          });
        });
      }
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
                      'Title:',
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
                        List<String> courseNames = [];
                        for (final documentSnapshot in snapshot.data!.docs) {
                          final documentName = documentSnapshot.id;
                          courseNames.add(documentName);
                        }
                        return DropdownButton<String>(
                            value: SelectedCourse,
                            dropdownColor: Colors.black,
                            items: courseNames
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
                              setState(() {
                                SelectedCourse = courseName;
                                getCourseDetails();
                              });
                            });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: DropdownButton<String>(
                          value: selectedLanguage,
                          dropdownColor: Colors.black,
                          items: LanguageTypes.map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )).toList(),
                          onChanged: (item) =>
                              setState(() => selectedLanguage = item),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white70 // Background color
                      ),
                  onPressed: () {
                    pickImage();
                  },
                  child: Container(
                    height: 140,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: _image != null
                        ? Image.memory(
                            _image,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text(
                              'Upload Image',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
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
                      'Introduction:',
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
                          hintText: 'Enter title here',
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
                      'Author:',
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
                        controller: _authorNameController,
                      ),
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
                      'Update Course',
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
