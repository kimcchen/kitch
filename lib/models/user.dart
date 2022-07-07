import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final String fullName;
  final List followers;
  final List following;

  const User({
    required this.username,
    required this.uid,
    required this.email,
    required this.fullName,
    required this.followers,
    required this.following,
  });

  // rearranges the info for us and returns it in a map so it can be used by firebase
  Map<String, dynamic> toJSON() => {
        "username": username,
        "uid": uid,
        "email": email,
        "fullname": fullName,
        "followers": followers,
        "following": following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      fullName: snapshot['fullname'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
