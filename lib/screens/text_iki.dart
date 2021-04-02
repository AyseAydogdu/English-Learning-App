import 'package:flutter/material.dart';

class TextIki extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TextIkiState();
  }
}

class TextIkiState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(child: Text("iki"))),
      persistentFooterButtons: <Widget>[
        new RaisedButton(
          child: Text("İlerle"),
          onPressed: () {
            Navigator.pushNamed(context, "/kazıkazan");
          },
        ),
      ],
    );
  }
}
