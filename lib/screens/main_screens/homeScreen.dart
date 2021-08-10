import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_auth/screens/alternative_screens/the_empty_screen.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: SpeedDial(
        child: const Icon(Icons.add),
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.directions_run),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: 'Open Camera',
            onPressed: () {
              setState(() {});
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.directions_walk),
            foregroundColor: Colors.black,
            backgroundColor: Colors.yellow,
            label: 'Select file file',
            onPressed: () {
              setState(() {});
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.directions_bike),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            label: 'Let\'s go cycling!',
            onPressed: () {
              setState(() {});
            },
          ),
        ],
        closedForegroundColor: Colors.black,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Colors.black,
      ),
      body: EmptyViewScreen(),
    );
  }
}
