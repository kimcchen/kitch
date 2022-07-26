import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: height * .01,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.account_circle_rounded,
                  size: 30,
                ),
                SizedBox(
                  width: width * .01,
                ),
                Text(
                  snap['username'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: width * .023,
                    ),
                    Text(snap['title'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.5),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      DateFormat.yMMMd().format(
                        snap['datePublished'].toDate(),
                      ),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ]
                                  .map(
                                    (e) => InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(e),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.more_vert,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * .01,
          ),
          // -------------------------------------------------------------------
          Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(snap['postUrl']),
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
                      child: Text(snap['description'],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      width: width * .05,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.local_fire_department,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text('${snap['likes'].length}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                    SizedBox(width: width * .05),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.mode_comment,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: width * .01),
                    Text(
                      '3',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
