
import 'package:borrow/screens/borrow_screeen.dart';
import 'package:borrow/screens/ad_form_screen.dart';
import 'package:borrow/screens/lend_screen.dart';
import 'package:borrow/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:borrow/screens/side_bar.dart';
import 'package:borrow/screens/ad_form_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  runApp(MyApp(googleSignIn: googleSignIn));
}

class MyApp extends StatelessWidget {
  final GoogleSignIn googleSignIn;

  MyApp({required this.googleSignIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
        routes: {
        '/': (context) => LoginScreen(),
          'borrow': (context) => BorrowScreen(),
          'lend': (context) => LendScreen(),
          'adform':(context)=>AdFormPage(),
        }
    );
  }
}


