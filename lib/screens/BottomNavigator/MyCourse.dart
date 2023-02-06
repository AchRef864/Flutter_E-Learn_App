import 'package:flutter/material.dart';
import '../LoginPage.dart';

class MyCourse extends StatefulWidget {
  const MyCourse({super.key});

  @override
  State<MyCourse> createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xff0A0B10),
        body: Stack(
          children: [
            dradient(-1.2, -0.8),
            dradient(1.2, 0.8),
            const Center(
              child: Text(
                'MyCourse',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
