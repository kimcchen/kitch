import 'package:auth_practice/screens/signup_email_password_screen.dart';
import 'package:auth_practice/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth_practice/widgets/text_field_input.dart';

class EmailPasswordLogin extends StatefulWidget {
  static String routeName = '/login-email-password';
  const EmailPasswordLogin({Key? key}) : super(key: key);

  @override
  State<EmailPasswordLogin> createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  int popCount = 0;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    String res = await context.read<FirebaseAuthMethods>().loginWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
    if ((res == 'success') && (popCount < 1)) {
      Navigator.pop(context);
      popCount += 1;
    }
    // if (popCount < 1) {
    //   Navigator.pop(context);
    //   popCount += 1;
    // }
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
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 315),
                      child: TextFieldInput(
                        textEditingController: emailController,
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 400),
                      child: TextFieldInput(
                        textEditingController: passwordController,
                        hintText: 'Password',
                        textInputType: TextInputType.text,
                        isPass: true,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 550),
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: loginUser,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text('Sign In'),
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
                      padding: EdgeInsets.only(top: 625),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, EmailPasswordSignup.routeName);
                            },
                            child: Text(
                              'Create one!',
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
