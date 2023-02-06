import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'HomePage.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      text: "Work",
                      children: [
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xffB40026),
                          ),
                          text: " Hard",
                        ),
                        TextSpan(
                          text: ",",
                        ),
                        TextSpan(
                          text: "\nDream",
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xffB40026),
                          ),
                          text: " Big",
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
                      hintText: "Username",
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Forgot Password? ",
                            style: TextStyle(
                              color: Color.fromARGB(185, 255, 255, 255),
                              fontFamily: "Courier",
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: "Reset\n",
                            style: TextStyle(
                              color: Color.fromARGB(255, 180, 0, 39),
                              decoration: TextDecoration.underline,
                              fontFamily: "Courier",
                              fontSize: 15,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('reset works');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
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
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Courier",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*onTapDown: (_) {
                      setState(() {
                        _buttonColor = Color.fromARGB(206, 10, 11, 16);
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _buttonColor = const Color(0xffB40026);
                      });
                    },*/
                  ),
                  const Text("\n"),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(122, 255, 255, 255),
                          thickness: 2,
                        ),
                      ),
                      Text(
                        " Don't Have An Account? ",
                        style: TextStyle(
                          color: Color.fromARGB(122, 255, 255, 255),
                          fontSize: 15,
                          fontFamily: "Courier",
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(122, 255, 255, 255),
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.Google,
                      text: "Sign Up Using Google",
                      onPressed: () {
                        _googleSignIn.signIn().then((userData) {
                          setState(() {
                            _isLoggedIn = true;
                            _userObj = userData!;
                            print(_userObj.displayName);
                            print(_userObj.email);
                          });
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.Facebook,
                      text: "Sign Up Using FaceBook",
                      onPressed: () {
                        print("facebook working");
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.GitHub,
                      text: "Sign Up Using GitHub",
                      onPressed: () {
                        print("GitHub working");
                      },
                    ),
                  ),
                  const Text("\n"),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "\nOr Sign Up Using  ",
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
                        text: "Sign Up",
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
                                  builder: (context) => SignUpPage()),
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

Container dradient(double x, double y) => Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            const Color(0xffB40026).withOpacity(0.2),
            const Color(0xffB40026).withOpacity(0),
          ],
          radius: 1.2,
          stops: const <double>[0, 1],
          center: Alignment(
            x,
            y,
          ),
        ),
      ),
    );
