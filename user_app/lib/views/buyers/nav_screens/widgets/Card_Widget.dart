import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:quizz/views/buyers/nav_screens/course_screen.dart';

class Card_Widget extends StatefulWidget {
  const Card_Widget({Key? key});

  @override
  State<Card_Widget> createState() => _Card_WidgetState();
}

class _Card_WidgetState extends State<Card_Widget> {
  void _navigateToCourse(String courseId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CoursePage(courseId: courseId)),
    );
  }

  final Stream<QuerySnapshot> _userStream =
      FirebaseFirestore.instance.collection('courses').snapshots();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: _userStream,
        builder:
            ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('something wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("loading");
          }
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      data['image'],
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Opacity(
                  opacity: 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              data['title'],
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              data['language'],
                              style: TextStyle(
                                color: Color.fromARGB(255, 39, 39, 39),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text(
                                  'ENROLL',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () {
                                  _navigateToCourse(document.id);
                                },
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
