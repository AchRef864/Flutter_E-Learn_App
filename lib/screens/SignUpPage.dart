import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'HomePage.dart';
import 'LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _obscureText = true;
  Color _buttonColor = Color(0xff0A0B10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0B10),
      body: Stack(
        children: [
          dradient(-1.2, -0.8),
          dradient(1.2, 0.8),
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Color.fromARGB(193, 255, 255, 255),
                        //fontFamily: "Courier",
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Courier",
                      ),
                      text: "Create An ",
                      children: [
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xffB40026),
                          ),
                          text: "Account",
                        ),
                        TextSpan(
                          text: ".",
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "\nUsername",
                    style: TextStyle(
                      color: Color.fromARGB(255, 192, 192, 192),
                      fontFamily: "Courier",
                      fontSize: 20,
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Courier",
                        color: Color.fromARGB(255, 192, 192, 192)),
                    focusNode: FocusNode(),
                    autofocus: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.face,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: "Email",
                      hintStyle: const TextStyle(
                        color: Color(0xff483538),
                        fontFamily: "Courier",
                      ),
                      fillColor: Colors.white.withOpacity(0.01),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "\nE-mail",
                    style: TextStyle(
                      color: Color.fromARGB(255, 192, 192, 192),
                      fontFamily: "Courier",
                      fontSize: 20,
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Courier",
                        color: Color.fromARGB(255, 192, 192, 192)),
                    focusNode: FocusNode(),
                    autofocus: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: "Email",
                      hintStyle: const TextStyle(
                        color: Color(0xff483538),
                        fontFamily: "Courier",
                      ),
                      fillColor: Colors.white.withOpacity(0.01),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "\nPassword",
                    style: TextStyle(
                      color: Color.fromARGB(255, 192, 192, 192),
                      fontFamily: "Courier",
                      fontSize: 20,
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Courier",
                        color: Color.fromARGB(255, 192, 192, 192)),
                    focusNode: FocusNode(),
                    autofocus: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.password_sharp,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility_sharp
                            : Icons.visibility_off_sharp),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: "Password",
                      hintStyle: const TextStyle(
                        color: Color(0xff483538),
                        fontFamily: "Courier",
                      ),
                      fillColor: Colors.white.withOpacity(0.01),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                    ),
                    obscureText: _obscureText,
                  ),
                  const Text(
                    "\nConfirm Password",
                    style: TextStyle(
                      color: Color.fromARGB(255, 192, 192, 192),
                      fontFamily: "Courier",
                      fontSize: 20,
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Courier",
                        color: Color.fromARGB(255, 192, 192, 192)),
                    focusNode: FocusNode(),
                    autofocus: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.password_sharp,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility_sharp
                            : Icons.visibility_off_sharp),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: "Password",
                      hintStyle: const TextStyle(
                        color: Color(0xff483538),
                        fontFamily: "Courier",
                      ),
                      fillColor: Colors.white.withOpacity(0.01),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(
                            0.1,
                          ),
                          width: 0.5,
                        ),
                      ),
                    ),
                    obscureText: _obscureText,
                  ),
                  const Text("\n"),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    color: const Color(0xffB40026),
                    height: 50,
                    minWidth: double.infinity,
                    child: Container(
                      child: Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Courier",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "\nGo Back To",
                            style: TextStyle(
                              color: Color.fromARGB(185, 255, 255, 255),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Courier",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                          color: Color.fromARGB(255, 180, 0, 39),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Courier",
                          fontSize: 15,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
