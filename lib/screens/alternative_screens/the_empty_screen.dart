import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Hello Sarra",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You can scan Documents with camera or upload existing documents from your device",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Icon(
                CupertinoIcons.doc_text,
                color: Colors.blueGrey[100],
                size: 200,
              )),
            ],
          ),
        ),
      ],
    );
  }
}
