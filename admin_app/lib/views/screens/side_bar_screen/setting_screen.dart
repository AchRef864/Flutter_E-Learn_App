import 'package:flutter/material.dart';

import '../../../auth/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '\SettingsScreen';
  const SettingsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 24.0),
        Center(
          child: ElevatedButton(
            child: Text("Logout"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ),
      ],
    );
  }
}
