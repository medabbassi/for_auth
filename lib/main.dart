import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_auth/firebase_options.dart';
import 'package:for_auth/screens/alternative_screens/forgot_password.dart';
import 'package:for_auth/screens/main_screens/authView.dart';
import 'package:for_auth/screens/main_screens/homeScreen.dart';
import 'package:for_auth/screens/main_screens/viewscreen.dart';
import 'dart:async';

import 'package:for_auth/screens/outscreens/opencamera.dart';

import 'screens/alternative_screens/profile_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AuthApp',
      theme: ThemeData(
        fontFamily: "OpenSans",
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthViewScreen(),
        '/first': (context) => HomeScreen(),
        '/second': (context) => ViewScreen(),
        '/succes': (context) => SuccessScreen(),
        '/reset_password': (context) => PasswordResetScreen(),
        '/profile': (context) => ProfileScreen(), // Add this line
      },
    );
  }
}
