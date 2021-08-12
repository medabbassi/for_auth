import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginViewScreen extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginViewScreen> {
  TextEditingController mail = TextEditingController();
  TextEditingController pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(tag: 'hero', child: FlutterLogo());
    final email = TextFormField(
      //controller: mail,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      initialValue: 'your email@provider.com',
      decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0))),
    );
    final password = TextFormField(
      //controller: pwd,
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      initialValue: 'your email@provider.com',
      decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0))),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/first');
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(12),
            color: Colors.lightBlueAccent,
            child: Center(
                child: Text('Log In', style: TextStyle(color: Colors.white)))),
      ),
    );
    final forgotLabel = TextButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: false,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: [
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
