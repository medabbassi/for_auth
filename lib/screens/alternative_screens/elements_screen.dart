import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElementViewScreen extends StatefulWidget {
  @override
  ElementViewScreenState createState() => ElementViewScreenState();
}

class ElementViewScreenState extends State<ElementViewScreen> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column();
        });
  }
}
