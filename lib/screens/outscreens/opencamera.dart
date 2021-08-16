import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:for_auth/screens/main_screens/homeScreen.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(
              _controller,
              child: Positioned(
                top: 0.0,
                right: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new IconButton(
                      icon: Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/first');
                      }),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(
          Icons.camera_alt,
          color: Colors.blue,
        ),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);
  static const routeName = '/first';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.file(File(imagePath)),
              ),
            ),
            Positioned(
                bottom: 0.0,
                height: MediaQuery.of(context).size.height * 1 / 8,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                              icon: Icon(
                                Icons.close_outlined,
                                color: Colors.blue,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.done,
                                color: Colors.blue,
                              )),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
          // child: Center(
          //   child: Column(
          //     children: [
          //       Container(
          //         height: MediaQuery.of(context).size.height,
          //         width: MediaQuery.of(context).size.width,
          //         child: Image.file(File(imagePath)),
          //       ),

          //       // Padding(
          //       //   padding: const EdgeInsets.all(16.0),
          //       //   child: Row(
          //       //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       //     children: [
          //       //       ElevatedButton(
          //       //           onPressed: () {
          //       //             Navigator.pop(context);
          //       //           },
          //       //           child: Text("Cancel")),
          //       //       ElevatedButton(
          //       //           onPressed: () {
          //       //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       //                 content: Text("Image upload succesfully")));
          //       //             Navigator.pushNamed(context, "/succes");
          //       //           },
          //       //           child: Text("Accept"))
          //       //     ],
          //       //   ),
          //       // )
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outlined,
              size: 100,
              color: Colors.blue,
            ),
            Text(
              "operation success",
              style: TextStyle(color: Colors.blue, fontSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text("Back to Home")),
            )
          ],
        ),
      ),
    );
  }
}
