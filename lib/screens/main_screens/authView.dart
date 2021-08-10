import 'package:flutter/cupertino.dart';
import 'package:for_auth/screens/alternative_screens/loginView.dart';

class AuthViewScreen extends StatefulWidget {
  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginViewScreen(),
    );
  }
}
