import 'package:auth_practice/screens/login_email_password_screen.dart';
import 'package:auth_practice/services/firebase_auth_methods.dart';
import 'package:auth_practice/utils/showSnackBar.dart';
import 'package:auth_practice/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  State<EmailPasswordSignup> createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  int popCount = 0;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    usernameController.dispose();
  }

  signUpUser() async {
    String res = await context.read<FirebaseAuthMethods>().signUpUser(
          email: emailController.text,
          password: passwordController.text,
          username: usernameController.text,
          fullName: fullNameController.text,
        );
    print(res);
    if ((res == 'success') && (popCount < 1)) {
      Navigator.pop(context);
      popCount += 1;
    } else if (res != 'success') {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    ClipPath(
                      clipper: ArcClipper(),
                      child: Container(
                        color: Colors.white,
                        height: 450,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_new_rounded),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 165),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 285),
                      height: 575,
                      width: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldInput(
                            textEditingController: fullNameController,
                            hintText: 'Full Name',
                            textInputType: TextInputType.emailAddress,
                          ),
                          TextFieldInput(
                            textEditingController: emailController,
                            hintText: 'Email',
                            textInputType: TextInputType.text,
                          ),
                          // SizedBox(
                          //   height:,
                          // ),
                          TextFieldInput(
                            textEditingController: usernameController,
                            hintText: 'Username',
                            textInputType: TextInputType.emailAddress,
                          ),
                          TextFieldInput(
                            textEditingController: passwordController,
                            hintText: 'Password',
                            textInputType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 625),
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: signUpUser,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text('Sign Up'),
                              SizedBox(
                                width: 90,
                              ),
                              Icon(Icons.arrow_forward_ios_rounded),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 695),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?'),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, EmailPasswordLogin.routeName);
                            },
                            child: Text(
                              'Sign In!',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * .5);
    var firstStart = Offset(size.width / 2, size.height - 150);
    var firstEnd = Offset(size.width, size.height * .5);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// TextFieldInput(
// textEditingController: emailController,
// hintText: 'Email',
// textInputType: TextInputType.text,
// ),
// TextFieldInput(
// textEditingController: passwordController,
// hintText: 'Password',
// textInputType: TextInputType.text,
// ),
// ElevatedButton(
// onPressed: signUpUser,
// child: const Text('Sign Up'),
// ),
