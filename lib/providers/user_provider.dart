import 'package:auth_practice/services/firebase_auth_methods.dart';
import 'package:flutter/widgets.dart';
import 'package:auth_practice/models/user.dart';

class UserProvider with ChangeNotifier {
  Userer? _user;
  final FirebaseAuthMethods _authMethods = FirebaseAuthMethods();

  Future<void> refreshUser() async {
    Userer user = await _authMethods.getUserDetails();
    print("THIS IS USER: ${user.toJSON()}");
    _user = user;
    if (_user != null) {
      print("THE USER IS NOT NULL");
    }
    notifyListeners();
  }

  Userer get getUser => _user!;
}
