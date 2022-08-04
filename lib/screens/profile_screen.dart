import 'package:auth_practice/providers/user_provider.dart';
import 'package:auth_practice/screens/login_email_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
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
                      // child: Container(
                      //   color: Colors.red[200],
                      //   height: 500,
                      // ),
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors:[
                                  Color(0xFFEF9A9A),
                                  Color.fromRGBO(255, 255, 255, 1),
                                ],
                                stops:[
                                  0.5,
                                  1.0,
                                ]
                            )
                        ),
                        height: 500,
                      ),
                    ),

                    Container(
                        alignment: AlignmentDirectional.topStart,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 25
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 25,
                                width: 8,
                              ),
                              Icon(
                                Icons.arrow_back,
                                size: 40,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  'Welcome Back,',
                                textScaleFactor: 2.0,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  'Luffy',
                                textScaleFactor: 2.0,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 175.0,
                                height: 175.0,
                                decoration: new BoxDecoration(
                                    color: Colors.grey[400],
                                    shape: BoxShape.circle
                                ),
                              ),
                              Container(
                                width: 165.0,
                                height: 165.0,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1629019725048-75f3fd5edd1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 20,
                                bottom: 0,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: new BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  ],
                                )
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.create_outlined, color: Colors.transparent,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Luffy',
                                  textScaleFactor: 2.0,
                                ),
                              ),
                              Icon(Icons.create_outlined,color: Colors.black,),
                            ],
                          ),
                          Text(
                              '@luffyofficial',
                            textScaleFactor: 1.3,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Memories',
                                textScaleFactor: 1.76,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                width: 120.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                                ),
                              ),
                              Container(
                                width: 120.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                                ),
                              ),
                              Container(
                                width: 120.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              )
                            ],
                          ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 160),
                              decoration: BoxDecoration(
                                color: Colors.red[200],
                                borderRadius: BorderRadius.all(Radius.circular(8.0))
                              ),
                              child: Text(
                                'View all',
                                textAlign: TextAlign.center,
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    )
    );
  }
}




