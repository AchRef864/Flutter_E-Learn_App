import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizz/views/buyers/auth/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizz/views/buyers/nav_screens/home_screen.dart';
import '../main_screen.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _useremailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String? errorMessage = '';
  bool isLogin = true;

  Future<List<Map<String, dynamic>>> getUsers() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('accounts')
        .doc('account')
        .collection('users')
        .get();

    final List<Map<String, dynamic>> users = [];
    for (final doc in snapshot.docs) {
      users.add(doc.data());
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Code',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                      text: 'Lingo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: _useremailController,
              style: TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                labelText: 'Email/Username',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Query the database for the user's email and password
                final snapshot = await _db
                    .collection('accounts')
                    .doc('account')
                    .collection('users')
                    .where('email', isEqualTo: _useremailController.text)
                    .where('password', isEqualTo: _passwordController.text)
                    .get();

                // Check if there's a match in the database
                if (snapshot.docs.length == 1) {
                  // TODO: Navigate to the user's profile or dashboard
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Warning'),
                        content: Text('Email or password is incorrect.'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                }
                _useremailController.clear();
                _passwordController.clear();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
