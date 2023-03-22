import 'package:flutter/material.dart';
import 'package:quizz/views/buyers/nav_screens/widgets/Banner_Widget.dart';
import 'package:quizz/views/buyers/nav_screens/widgets/Category_Text.dart';
import 'package:quizz/views/buyers/nav_screens/widgets/Search_Bar.dart';
import 'package:quizz/views/buyers/nav_screens/widgets/Welcome_Text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Welcome_Text(),
        Search_Bar(),
        Banner_Widget(),
        Category_Text()
      ],
    );
  }
}
