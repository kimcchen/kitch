import 'dart:ui';

import 'package:auth_practice/screens/signup_email_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_email_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Widget svg = SvgPicture.asset(
    'images/undraw_cooking_lyxy.svg',
    width: 225,
    height: 225,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFEF9A9A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    ClipPath(
                      clipper: ArcClipper(),
                      child: Container(
                        color: Colors.white,
                        height: 500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 75),
                      child: const Text(
                        'KITCH',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 150),
                      child: svg,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 425),
                      child: const Text(
                        'Share your cooking with friends!',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => EmailPasswordSignup()));
                        Navigator.pushNamed(
                            context, EmailPasswordSignup.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, EmailPasswordLogin.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFFEF9A9A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 165);
    var firstStart = Offset(size.width / 2, size.height - 250);
    var firstEnd = Offset(size.width, size.height - 165);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// child: Column(
// children: [
// SizedBox(
// height: 100,
// ),
// ElevatedButton(
// onPressed: () {
// Navigator.pushNamed(
// context, EmailPasswordSignup.routeName);
// },
// style: ElevatedButton.styleFrom(
// primary: Colors.black,
// ),
// child: const Text('Email/Password Sign Up'),
// ),
// ElevatedButton(
// onPressed: () {
// Navigator.pushNamed(
// context, EmailPasswordLogin.routeName);
// },
// style: ElevatedButton.styleFrom(
// primary: Colors.black,
// ),
// child: const Text('Email/Password Login'),
// ),
// ],
// ),

// WHAT GOES INSIDE CONTAINER
// padding: const EdgeInsets.symmetric(horizontal: 20),
// decoration: const BoxDecoration(
// color: Colors.blueAccent,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(200.0),
// topRight: Radius.circular(200.0)),
// ),
