import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
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
          Icon(
            Icons.person_add_alt_1_rounded,
            size: 30,
            color: Colors.black,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              // height: 10,
              height: height * .02,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * .02,
                ),
                Icon(
                  Icons.account_circle_rounded,
                  size: 30,
                ),
                SizedBox(
                  width: width * .01,
                ),
                Text(
                  'user_123456',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .01,
            ),
            Row(
              children: [
                SizedBox(
                  width: height * .02,
                ),
                Text('Food Title',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1.5),
                SizedBox(
                  width: height * .13,
                ),
                Text(
                  '07/26/22 at 12:00 PM',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: height * .01,
            ),
            Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80',
                    ),
                  ),
                ),
                height: height * .475,
              ),
              Container(
                  height: height * .475,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.transparent.withOpacity(0.0),
                            Colors.grey.withOpacity(0.0),
                            Colors.black45,
                          ],
                          stops: [
                            0.8,
                            0.7,
                            1.0,
                          ])),
                  alignment: Alignment
                      .bottomLeft, // This aligns the child of the container
                  child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 5.0,
                          left: 12,
                          right: 10), //some spacing to the child from bottom
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * .6,
                            child: Text(
                                'This is a caption that describes the food...',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(
                            width: width * .05,
                          ),
                          Icon(
                            Icons.local_fire_department,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text('12',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(width: width * .05),
                          Icon(
                            Icons.mode_comment,
                            size: 25,
                            color: Colors.white,
                          ),
                          SizedBox(width: width * .01),
                          Text('3',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500))
                        ],
                      ))),
            ]),
          ],
        ),
      ),
    );
  }
}
