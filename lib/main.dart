import 'package:auth_practice/providers/user_provider.dart';
import 'package:auth_practice/screens/feed_screen.dart';
import 'package:auth_practice/screens/profile_screen.dart';
import 'package:auth_practice/screens/home_screen.dart';
import 'package:auth_practice/screens/login_email_password_screen.dart';
import 'package:auth_practice/screens/login_screen.dart';
import 'package:auth_practice/screens/new_post_screen.dart';
import 'package:auth_practice/screens/search_screen.dart';
import 'package:auth_practice/services/firebase_auth_methods.dart';
import 'package:auth_practice/services/firestore_methods.dart';
import 'package:auth_practice/widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/signup_email_password_screen.dart';

Future<void> main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  //
  runApp(MyApp());
}

void printMethod() {
  print('I AM RECREATING PAGE');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(),
        ),
        // StreamProvider(
        //   create: (context) => context.read<FirebaseAuthMethods>().authState,
        //   initialData: null,
        // ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kitch',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ProfileScreen();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            return const LoginScreen();
            // DON'T FORGET TO ADD CIRCULAR PROGRESS INDICATOR
          },
        ),
        routes: {
          EmailPasswordSignup.routeName: (context) =>
              const EmailPasswordSignup(),
          EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
        },
        // home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // makes BuildContext listen to changes on User
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return HomeScreen();
    }
    return LoginScreen();
  }
}
