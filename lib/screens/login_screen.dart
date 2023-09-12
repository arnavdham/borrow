import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'borrow_screeen.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              Image.asset(
                'assets/final.jpg',
                width: 200.0,
                height: 200.0,
              ),
              const SizedBox(height: 5,),
              const Text(
                'BORROW',
                style: TextStyle(
                  fontFamily: 'EuphoriaScript',
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
              const SizedBox(
                height: 150.0,
              ),
              const Text(
                'Log in to your Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final user = await signInWithGoogle();
                  if (user != null) {
                    // Sign-in was successful, navigate to the next screen.
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return BorrowScreen();
                        },
                      ),
                    );
                  } else {
                    // Sign-in failed or was canceled, handle it here.
                    // Show an error message to the user if needed.
                  }
                },
                child: Text('Sign in with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        // User canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (error) {
      // Handle and log the error
      print("Error signing in with Google: $error");
      return null;
    }
  }
}
