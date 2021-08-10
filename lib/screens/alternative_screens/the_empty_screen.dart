import 'package:flutter/cupertino.dart';

class EmptyViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/empty.png",
        height: 100,
        width: 100,
      ),
    );
  }
}
