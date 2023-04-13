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
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final List<String> adminsNames = [];
  String? SelectedAdmin;
  String? _usernameValue;
  String? _passwordValue;

  getAdminDetails() async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('accounts')
        .doc('account')
        .collection('admins')
        .doc(SelectedAdmin);
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      setState(() {
        _usernameController.text =
            (doc.data() as Map<String, dynamic>)['username'];
        _passwordController.text =
            (doc.data() as Map<String, dynamic>)['password'];
      });
    }
  }

  uploadToFirebaseStore() async {
    EasyLoading.show(status: 'Uploading ...');
    if ((!_usernameController.text.isEmpty) &&
        (!_passwordController.text.isEmpty) &&
        (SelectedAdmin != null)) {
      _usernameValue = await _usernameController.text;
      _passwordValue = await _passwordController.text;
      await _firestore
          .collection('accounts')
          .doc('account')
          .collection('admins')
          .doc(SelectedAdmin)
          .update({
        'username': _usernameValue,
        'password': _passwordValue,
        'date': DateTime.now(),
      }).whenComplete(() {
        EasyLoading.showSuccess('Great Success!');
        setState(() {
          _usernameController.clear();
          _passwordController.clear();
          SelectedAdmin = null;
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
                      'Admin:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('accounts')
                          .doc('account')
                          .collection('admins')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return DropdownButton<String>(
                            items: [],
                            onChanged: null,
                          );
                        }
                        List<String> adminsNames = [];
                        for (final documentSnapshot in snapshot.data!.docs) {
                          final adminName = documentSnapshot.id;
                          adminsNames.add(adminName);
                        }
                        return DropdownButton<String>(
                          value: SelectedAdmin,
                          dropdownColor: Colors.black,
                          items: adminsNames
                              .map((AdminName) => DropdownMenuItem(
                                    value: AdminName,
                                    child: Text(
                                      AdminName,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (AdminName) => setState(() {
                            SelectedAdmin = AdminName;
                            getAdminDetails();
                          }),
                        );
                      },
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      height: 250,
                      width: 250,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Username:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: 'Enter new username',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Password:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'Enter new password',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                            ),
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
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      uploadToFirebaseStore();
                    },
                    child: Text(
                      'Update Admin',
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
