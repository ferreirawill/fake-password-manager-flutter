import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Center(
        child: Image(
          image:AssetImage("images/light.png"),
        ),
      ),
      appBar: AppBar(
        title: Center(
          child: Text("Almost There... :)"),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
    ),
  ));
}
