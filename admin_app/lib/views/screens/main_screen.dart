import 'package:admin_app/views/screens/side_bar_screen/announcements_screen.dart';
import 'package:admin_app/views/screens/side_bar_screen/courses_screen.dart';
import 'package:admin_app/views/screens/side_bar_screen/dashboard_screen.dart';
import 'package:admin_app/views/screens/side_bar_screen/quizzes_screen.dart';
import 'package:admin_app/views/screens/side_bar_screen/setting_screen.dart';
import 'package:admin_app/views/screens/side_bar_screen/subscription_screen.dart';
import 'package:admin_app/views/screens/side_bar_screen/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();
  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;

      case AnnouncementsScreen.routeName:
        setState(() {
          _selectedItem = AnnouncementsScreen();
        });
        break;

      case CoursesScreen.routeName:
        setState(() {
          _selectedItem = CoursesScreen();
        });
        break;

      case QuizzesScreen.routeName:
        setState(() {
          _selectedItem = QuizzesScreen();
        });
        break;

      case SettingsScreen.routeName:
        setState(() {
          _selectedItem = SettingsScreen();
        });
        break;

      case SubscriptionsScreen.routeName:
        setState(() {
          _selectedItem = SubscriptionsScreen();
        });
        break;

      case UsersScreen.routeName:
        setState(() {
          _selectedItem = UsersScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      sideBar: SideBar(
        items: [
          AdminMenuItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            route: DashboardScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Users',
            icon: Icons.verified_user,
            route: UsersScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Announcements',
            icon: Icons.discount,
            route: AnnouncementsScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Courses',
            icon: Icons.book,
            route: CoursesScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Quizzes',
            icon: Icons.question_mark,
            route: QuizzesScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Subscriptions',
            icon: Icons.add_alert,
            route: SubscriptionsScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Settings',
            icon: Icons.settings,
            route: SettingsScreen.routeName,
          ),
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
      ),
      body: _selectedItem,
    );
  }
}
