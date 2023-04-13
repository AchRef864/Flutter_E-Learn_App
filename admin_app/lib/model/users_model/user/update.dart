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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final List<String> adminsNames = [];
  String? SelecteUser;
  String? _emailValue;
  String? _usernameValue;
  String? _passwordValue;

  getUserDetails() async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('accounts')
        .doc('account')
        .collection('users')
        .doc(SelecteUser);
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      setState(() {
        _emailController.text = (doc.data() as Map<String, dynamic>)['email'];
        _usernameController.text =
            (doc.data() as Map<String, dynamic>)['username'];
        _passwordController.text =
            (doc.data() as Map<String, dynamic>)['password'];
      });
    }
  }

  uploadToFirebaseStore() async {
    EasyLoading.show(status: 'Uploading ...');
    if ((!_emailController.text.isEmpty) &&
        (!_usernameController.text.isEmpty) &&
        (!_passwordController.text.isEmpty) &&
        (SelecteUser != null)) {
      _emailValue = await _emailController.text;
      _usernameValue = await _usernameController.text;
      _passwordValue = await _passwordController.text;
      await _firestore
          .collection('accounts')
          .doc('account')
          .collection('users')
          .doc(SelecteUser)
          .update({
        'email': _emailValue,
        'username': _usernameValue,
        'password': _passwordValue,
        'date': DateTime.now(),
      }).whenComplete(() {
        EasyLoading.showSuccess('Great Success!');
        setState(() {
          _emailController.clear();
          _usernameController.clear();
          _passwordController.clear();
          SelecteUser = null;
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
                      'User:',
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
                          .collection('users')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return DropdownButton<String>(
                            items: [],
                            onChanged: null,
                          );
                        }
                        List<String> usersNames = [];
                        for (final documentSnapshot in snapshot.data!.docs) {
                          final userName = documentSnapshot.id;
                          usersNames.add(userName);
                        }
                        return DropdownButton<String>(
                          value: SelecteUser,
                          dropdownColor: Colors.black,
                          items: usersNames
                              .map((UserName) => DropdownMenuItem(
                                    value: UserName,
                                    child: Text(
                                      UserName,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (UserName) => setState(() {
                            SelecteUser = UserName;
                            getUserDetails();
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
                              'Email:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter new email',
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
                      'Update User',
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
