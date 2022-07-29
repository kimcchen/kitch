import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String uid;
  final String description;
  final String title;
  final String postId;
  final datePublished;
  final String postUrl;
  final likes;
  final comments;

  const Post({
    required this.username,
    required this.uid,
    required this.description,
    required this.title,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.likes,
    required this.comments,
  });

  // rearranges the info for us and returns it in a map so it can be used by firebase
  Map<String, dynamic> toJSON() => {
        "username": username,
        "uid": uid,
        "description": description,
        "title": title,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "likes": likes,
        "comments": comments,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      title: snapshot['title'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
      comments: snapshot['comments'],
    );
  }
}
