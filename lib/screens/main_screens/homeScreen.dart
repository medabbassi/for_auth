import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_auth/screens/alternative_screens/the_empty_screen.dart';
import 'package:for_auth/screens/outscreens/opencamera.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:filesystem_picker/filesystem_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late final cameras;
  late final firstCamera;
  late Directory rootPath;
  Future<void> initCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  late String file_path;

  Future<String> returnFile() async {
    return file_path = await FilesystemPicker.open(
      title: 'Open file',
      context: context,
      rootDirectory: rootPath,
      fsType: FilesystemType.file,
      folderIconColor: Colors.teal,
      allowedExtensions: ['.txt'],
      fileTileSelectMode: FileTileSelectMode.wholeTile,
    );
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    returnFile();
  }

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
            onPressed: () async {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TakePictureScreen(camera: firstCamera)));
              });
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
