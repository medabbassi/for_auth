import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewScreen extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginViewScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = ''; // Variable to store error message

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: FlutterLogo(
        size: 80,
      ),
    );
    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
      ),
    );
    final password = TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
        onPressed: () async {
          try {
            UserCredential userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
            if (userCredential.user!.uid.isNotEmpty) {
              Navigator.of(context).pushNamed('/first');
            }
            // Successfully logged in, navigate to the desired screen
          } on FirebaseAuthException catch (e) {
            // Handle login error
            if (e.code == 'user-not-found') {
              setState(() {
                errorMessage = 'No user found for that email.';
              });
            } else if (e.code == 'wrong-password') {
              setState(() {
                errorMessage = 'Wrong password provided.';
              });
            } else {
              setState(() {
                errorMessage = 'Error: ${e.message}';
              });
            }
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text('Log In', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
    final errorText = Text(
      errorMessage,
      style: TextStyle(color: Colors.red),
    );

    final forgotLabel = TextButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/reset_password');
      },
    );
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // ... existing code ...

    final googleSignInButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
        onPressed: () async {
          try {
            GoogleSignInAccount? googleUser = await googleSignIn.signIn();
            if (googleUser != null) {
              GoogleSignInAuthentication googleAuth =
                  await googleUser.authentication;
              AuthCredential credential = GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );
              UserCredential userCredential =
                  await FirebaseAuth.instance.signInWithCredential(credential);

              // Successfully logged in, navigate to the desired screen
              if (userCredential.user!.uid.isNotEmpty) {
                Navigator.of(context).pushNamed('/first');
              }
            }
          } catch (e) {
            print("Google Sign-In error: $e");
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text('Log In with Google',
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            SizedBox(height: 8.0),
            errorText,
            forgotLabel,
            googleSignInButton
          ],
        ),
      ),
    );
  }
}
