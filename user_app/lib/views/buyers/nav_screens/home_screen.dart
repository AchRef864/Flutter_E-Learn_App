import 'package:flutter/material.dart';
import 'package:quizz/views/buyers/nav_screens/widgets/Banner_Widget.dart';
import 'package:quizz/views/buyers/nav_screens/widgets/Category_Text.dart';
import 'package:quizz/views/buyers/nav_screens/widgets/Welcome_Text.dart';
import 'package:quizz/views/buyers/nav_screens/widgets/Card_Widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Welcome_Text(),
          Banner_Widget(),
          Category_Text(),
          Card_Widget()
        ],
      ),
    );
  }
}
