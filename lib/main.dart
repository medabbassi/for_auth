import 'package:flutter/material.dart';
import 'package:for_auth/screens/main_screens/authView.dart';
import 'package:for_auth/screens/main_screens/homeScreen.dart';
import 'package:for_auth/screens/main_screens/viewscreen.dart';
import 'dart:async';

import 'package:for_auth/screens/outscreens/opencamera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
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
      },
    );
  }

  static of(BuildContext context) {}
}
