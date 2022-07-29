import 'package:auth_practice/providers/user_provider.dart';
import 'package:auth_practice/screens/comments_screen.dart';
import 'package:auth_practice/services/firestore_methods.dart';
import 'package:auth_practice/widgets/like_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap['postId'])
        .collection('comments')
        .get();
    commentLen = snap.docs.length;
  }

  // Future<Stream<QuerySnapshot<Object?>>> getComments() async {
  //   return FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(widget.snap['postId'])
  //       .collection('comments')
  //       .snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    final Userer user = Provider.of<UserProvider>(context).getUser;
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
                  widget.snap['username'],
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
                    Text(widget.snap['title'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.5),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      DateFormat.yMMMd().format(
                        widget.snap['datePublished'].toDate(),
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
                                      onTap: () async {
                                        FirestoreMethods()
                                            .deletePost(widget.snap['postId']);
                                        Navigator.pop(context);
                                      },
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
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                widget.snap['postId'],
                // widget.snap['uid'],
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.snap['postUrl']),
                  ),
                ),
                height: height * .475,
              ),
              // SizedBox(
              //   height: height * .475,
              //   width: width * 1,
              //   child: AspectRatio(
              //     aspectRatio: 487 / 451,
              //     child: Container(
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: NetworkImage(widget.snap['postUrl']),
              //           fit: BoxFit.fill,
              //           alignment: FractionalOffset.topCenter,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Center(
                child: AnimatedOpacity(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(
                      Icons.local_fire_department,
                      color: Colors.amber,
                      size: 120,
                    ),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
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
                        child: Text(widget.snap['description'],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        width: width * .05,
                      ),
                      LikeAnimation(
                        isAnimating: widget.snap['likes'].contains(user.uid),
                        smallLike: true,
                        child: GestureDetector(
                          onTap: () async {
                            await FirestoreMethods().likePost(
                              widget.snap['postId'],
                              user.uid,
                              widget.snap['likes'],
                            );
                          },
                          child: widget.snap['likes'].contains(user.uid)
                              ? Icon(
                                  Icons.local_fire_department,
                                  size: 30,
                                  color: Colors.amber,
                                )
                              : Icon(
                                  Icons.local_fire_department_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      Text('${widget.snap['likes'].length}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      SizedBox(width: width * .05),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentsScreen(
                                snap: widget.snap,
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.mode_comment,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: width * .01),
                      Text(
                        '${widget.snap['comments'].length}',
                        // '$commentLen',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
