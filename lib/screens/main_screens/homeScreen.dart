import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:for_auth/screens/alternative_screens/the_empty_screen.dart';
import 'package:for_auth/screens/outscreens/opencamera.dart';
import 'package:path/path.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import '../../model/image.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late final cameras;
  late final firstCamera;
  File? file;
  ImageModel? imageModel;
  List<String> selectedFilePaths =
      []; // Maintain a list to store selected file paths

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;

    // Extract the list of selected file paths
    List<String> filePaths = result.files.map((file) => file.path!).toList();

    setState(() {
      selectedFilePaths = filePaths; // Update the list of selected file paths
    });
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
      ),
    );

    final selectedFilesWidget = Column(
      children: selectedFilePaths.map((filePath) {
        return ListTile(
          leading: Icon(
            Icons.attachment,
            color: Colors.blue,
          ),
          title: Text(basename(filePath)),
          // You can add additional UI components or actions for each selected file
        );
      }).toList(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: Text(
            "Upload Plus +",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
          ),
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
            onPressed: () async {
              setState(() async {
                await selectFile();
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: listofitems,
                  ),
                  SizedBox(height: 16.0),
                  // Display the list of selected files
                  selectedFilesWidget,
                ],
              ),
            ),
    );
  }
}
