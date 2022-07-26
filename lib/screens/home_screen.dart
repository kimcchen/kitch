import 'package:auth_practice/providers/user_provider.dart';
import 'package:auth_practice/screens/login_screen.dart';
import 'package:auth_practice/screens/new_post_screen.dart';
import 'package:auth_practice/services/firebase_auth_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth_practice/models/user.dart' as model;
import 'package:auth_practice/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    Userer user = Provider.of<UserProvider>(context).getUser;
    // User user = Provider.of<UserProvider>(context).getUser as User;

    // final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        leading: Icon(Icons.people_alt_outlined),
        title: Text('Feed us'),
        actions: [
          Icon(Icons.picture_as_pdf),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.fullName),
            ElevatedButton(
              onPressed: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewPost()),
          );
        },
      ),
    );
  }
}
