import 'dart:typed_data';

import 'package:auth_practice/screens/search_screen.dart';
import 'package:auth_practice/widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:auth_practice/providers/user_provider.dart';

import '../utils/utils.dart';
import 'new_post_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('kitch',
                textScaleFactor: 1.5,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Icon(
              Icons.local_fire_department_sharp,
              size: 40,
              color: Colors.black,
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            child: Icon(
              Icons.person_add_alt_1_rounded,
              size: 30,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 15),
          Icon(
            Icons.account_circle_rounded,
            size: 40,
            color: Colors.black,
          ),
          SizedBox(width: 12)
        ],
      ),
      // -----------------------------------------------------------------------
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => PostCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewPost()),
          );
        },
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
