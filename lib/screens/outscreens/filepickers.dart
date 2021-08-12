import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_auth/model/image.dart';
import 'package:for_auth/widgets/buttonwidget.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerPage extends StatefulWidget {
  @override
  _FilePickerPageState createState() => _FilePickerPageState();
}

class _FilePickerPageState extends State<FilePickerPage> {
  //UploadTask? task;
  File? file;
  ImageModel? imageModel;
  List<String>? paths;
  var path;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  void addPath() {}
  @override
  void initState() {
    super.initState();
    selectFile();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectFile();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Center(
      child: Container(
        color: Colors.amber,
        child: Column(
          children: [Text(fileName)],
        ),
      ),
    );
  }
}
