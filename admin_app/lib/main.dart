import 'dart:io';

import 'package:admin_app/views/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid
        ? FirebaseOptions(
            apiKey: "AIzaSyCfFiJHuEq0Hlmq9C8Ej1-Y_6ssS5ELWFo",
            projectId: "e-learning-15772",
            messagingSenderId: "833205764016",
            appId: "1:833205764016:web:cc9fc8807847e0c3642075",
            storageBucket: "e-learning-15772.appspot.com",
          )
        : null,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Color.fromARGB(255, 27, 27, 27), //<-- SEE HERE
      ),
      debugShowCheckedModeBanner: false,
      title: "flutter demo",
      home: MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
