import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizz/views/buyers/auth/login_screen.dart';
import 'package:quizz/views/buyers/auth/register_screen.dart';
import 'package:quizz/views/buyers/main_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
/*import 'package:quizz/screens/Home/MainPage.dart';
import 'package:quizz/screens/SignUpPage.dart';
import 'package:quizz/util/route_names.dart';
import 'screens/LoginPage.dart';*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Courier',
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Color.fromARGB(255, 27, 27, 27), //<-- SEE HERE
      ),
      debugShowCheckedModeBanner: false,
      title: "flutter demo",
      home: LoginPage(),
    );
  }
}
