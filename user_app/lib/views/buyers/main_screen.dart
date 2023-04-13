import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'nav_screens/account_screen.dart';
import 'nav_screens/course_screen.dart';
import 'nav_screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  List<Widget> _pages = [HomeScreen(), AccountScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Color.fromARGB(255, 189, 189, 189),
        showUnselectedLabels: true,
        selectedFontSize: 15,
        unselectedFontSize: 8,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 20, 20, 20),
            icon: Icon(
              CupertinoIcons.home,
            ),
            label: 'HOME',
          ),
          /*BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 20, 20, 20),
            icon: Icon(CupertinoIcons.book),
            label: 'COURSES',
          ),*/
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 20, 20, 20),
            icon: Icon(CupertinoIcons.person),
            label: 'ACCOUNT',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
