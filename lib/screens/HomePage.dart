import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:quizz/screens/BottomNavigator/Account.dart';
import 'package:quizz/screens/BottomNavigator/Home.dart';
import 'package:quizz/screens/BottomNavigator/PlayGround.dart';
import 'package:quizz/screens/BottomNavigator/MyCourse.dart';
import 'LoginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    MyCourse(),
    PlayGround(),
    Account(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0A0B10),
        title: const Text(
          "E-Learn",
          style: TextStyle(
            color: const Color.fromARGB(193, 255, 255, 255),
          ),
        ),
        leading: Icon(
          Icons.menu,
        ),
      ),
      backgroundColor: const Color(0xff0A0B10),
      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
          dradient(-1.2, -0.8),
          dradient(1.2, 0.8),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'MyCourses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'PlayGround',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color.fromARGB(193, 255, 255, 255),
        selectedItemColor: const Color(0xffB40026),
        backgroundColor: const Color(0xff0A0B10),
        onTap: _onItemTapped,
      ),
    );
  }
}
