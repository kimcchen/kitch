import 'package:auth_practice/providers/user_provider.dart';
import 'package:auth_practice/screens/login_screen.dart';
import 'package:auth_practice/services/firebase_auth_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth_practice/models/user.dart' as model;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';

  @override
  void initState() {
    super.initState();
    // addData();
  }

  // addData() async {
  //   UserProvider _userProvider = Provider.of(context, listen: false);
  //   await _userProvider.refreshUser();
  // }

  @override
  Widget build(BuildContext context) {
    // model.User userer =
    //     Provider.of<UserProvider>(context).getUser as model.User;

    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(userer.email),
            Text(user.email!),
            ElevatedButton(
              onPressed: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
