import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class update extends StatefulWidget {
  const update({super.key});

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? fileName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _newTitleController = TextEditingController();
  String? _newTitleValue;
  String? SelectedBanner;
  String imageUrl = '';
  String download_Url = '';
  dynamic _image;

  getBannerTitle() async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('banners').doc(SelectedBanner);

    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      _newTitleController.text = (doc.data() as Map<String, dynamic>)['title'];
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
    Reference ref = _storage.ref().child('Banners').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadToFirebaseStore() async {
    EasyLoading.show(status: 'Updating ...');

    if (SelectedBanner != null &&
        (_image != null || _newTitleController.text.isNotEmpty)) {
      if (_image == null) {
        _newTitleValue = await _newTitleController.text;
        await _firestore.collection("banners").doc(SelectedBanner).update({
          'title': _newTitleValue,
          'date': DateTime.now(),
        }).whenComplete(() {
          EasyLoading.showSuccess('Data Updated!');
          setState(() {
            _newTitleController.clear();
          });
        });
      } else if (_newTitleController.text.isEmpty) {
        String imageUrl = await _uploadToStorage(_image);
        await _firestore.collection("banners").doc(SelectedBanner).update({
          'image': imageUrl,
          'date': DateTime.now(),
        }).whenComplete(() {
          EasyLoading.showSuccess('Data Updated!');
          setState(() {
            _image = null;
          });
        });
      } else {
        String imageUrl = await _uploadToStorage(_image);
        _newTitleValue = await _newTitleController.text;
        await _firestore.collection("banners").doc(SelectedBanner).update({
          'title': _newTitleValue,
          'image': imageUrl,
          'date': DateTime.now(),
        }).whenComplete(() {
          EasyLoading.showSuccess('Data Updated!');
          setState(() {
            _image = null;
            _newTitleController.clear();
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
                        'Old Title:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('banners')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return DropdownButton<String>(
                              items: [],
                              onChanged: null,
                            );
                          }
                          List<String> bannersNames = [];
                          for (final documentSnapshot in snapshot.data!.docs) {
                            final documentName = documentSnapshot.id;
                            bannersNames.add(documentName);
                          }
                          return DropdownButton<String>(
                              value: SelectedBanner,
                              dropdownColor: Colors.black,
                              items: bannersNames
                                  .map((bannerName) => DropdownMenuItem(
                                        value: bannerName,
                                        child: Text(
                                          bannerName,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (bannerName) async {
                                setState(() {
                                  SelectedBanner = bannerName;
                                  getBannerTitle();
                                });
                              });
                        },
                      ),
                      Text(
                        'New Title:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter new announcement',
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
                        'Update Banner',
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
