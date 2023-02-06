import 'package:flutter/material.dart';
import '../LoginPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                'Home',
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
