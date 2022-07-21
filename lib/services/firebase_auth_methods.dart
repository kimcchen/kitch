import 'package:auth_practice/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/utils.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  // GET USER INFO
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // STATE PERSISTENCE
  Stream<User?> get authState => _auth.authStateChanges();

  // USER SIGN UP
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String fullName,
  }) async {
    String res = 'Some error occurred.';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          fullName.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        // add user to our database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          fullName: fullName,
          followers: [],
          following: [],
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJSON());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // EMAIL SIGN UP
  // Future<void> signUpWithEmail({
  //   required String email,
  //   required String password,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     // await sendEmailVerification(context);
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!);
  //   }
  // }

  // USER LOGIN
  Future<String> loginWithEmail({
    required email,
    required password,
    required BuildContext context,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      }
      // if (!_auth.currentUser!.emailVerified) {
      //   await sendEmailVerification(context);
      // }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  // EMAIL VERIFICATION

  // Future<void> sendEmailVerification(BuildContext context) async {
  //   try {
  //     _auth.currentUser!.sendEmailVerification();
  //     showSnackBar(context, 'Email verification sent!');
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!);
  //   }
  // }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
