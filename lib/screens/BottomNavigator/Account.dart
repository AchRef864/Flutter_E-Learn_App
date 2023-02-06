import 'package:flutter/material.dart';
import '../LoginPage.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
                'Account',
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
