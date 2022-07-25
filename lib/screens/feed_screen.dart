import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('kitch',
        textScaleFactor: 1.5,
        style: TextStyle(
          color: Colors.black)
        ),
        actions: [
          Icon(Icons.person_add_alt_1_rounded),
          Icon(Icons.account_circle_rounded),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10
                ),
                Icon(Icons.account_circle_rounded,
                size: 30,),
                SizedBox(
                  width: 5,
                ),
                Text('user_123456'),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Text('Food Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ) ,
                textScaleFactor: 1.5
                ),
                SizedBox(
                  width: 155,
                ),
                Text(
                    '00/00/00 at 00:00 PM'
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Image(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80'
              ),
                // image: AssetImage(
                //     'george-zheng-0Kbjfwunink-unsplash.jpg'
                // ),
            ),
          ],
        ),
      ),
    );
  }
}