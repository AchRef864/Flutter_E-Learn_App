import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AnnouncementsScreen extends StatefulWidget {
  static const String routeName = '\AnnouncementsScreen';

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  dynamic _image;
  String? fileName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _textFieldController = TextEditingController();
  String? _textFieldValue;

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
    Reference ref = _storage.ref().child('Banners').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadToFirebaseStore() async {
    EasyLoading.show(status: 'Uploading ...');
    if ((_image != null) && (!_textFieldController.text.isEmpty)) {
      String imageUrl = await _uploadToStorage(_image);
      _textFieldValue = await _textFieldController.text;
      await _firestore.collection("banners").doc(_textFieldValue).set({
        'title': _textFieldValue,
        'image': imageUrl,
        'date': DateTime.now(),
      }).whenComplete(() {
        EasyLoading.showSuccess('Great Success!');
        setState(() {
          _image = null;
          _textFieldController.clear();
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
              'Announcements',
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
                          hintText: 'Enter announcement here',
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
                padding: const EdgeInsets.all(50.0),
                child: SizedBox(
                  width: 150,
                  height: 50, // set desired width here
                  child: ElevatedButton(
                    onPressed: () {
                      uploadToFirebaseStore();
                    },
                    child: Text(
                      'Add Banner',
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
