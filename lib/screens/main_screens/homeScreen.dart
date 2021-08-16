import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_auth/model/image.dart';
import 'package:for_auth/screens/alternative_screens/the_empty_screen.dart';

import 'package:for_auth/screens/outscreens/opencamera.dart';
import 'package:path/path.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late final cameras;
  late final firstCamera;
  File? file;
  ImageModel? imageModel;
  List<String>? paths;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    final listofitems = Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Icon(
            Icons.image,
            color: Colors.blue,
          ),
          title: Text(fileName),
          trailing: IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/succes");
            },
          ),
        ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          "Upload Plus +",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Icon(
                Icons.exit_to_app,
                color: Colors.blue,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      floatingActionButton: SpeedDial(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(
              Icons.folder_outlined,
              color: Colors.white,
            ),
            foregroundColor: Colors.blue,
            backgroundColor: Colors.blue,
            label: 'Browse Files',
            onPressed: () {
              setState(() async {
                selectFile();
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.add_a_photo_outlined,
              color: Colors.white,
            ),
            foregroundColor: Colors.blue,
            backgroundColor: Colors.blue,
            label: 'Scan document',
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
        ],
        closedForegroundColor: Colors.blue,
        openForegroundColor: Colors.blue,
        closedBackgroundColor: Colors.blue,
        openBackgroundColor: Colors.blue,
      ),
      body: (fileName == "No File Selected")
          ? EmptyViewScreen()
          : Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Padding(
                  padding: const EdgeInsets.only(top: 18), child: listofitems),
            ),
    );
  }
}
