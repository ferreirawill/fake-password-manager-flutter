import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'navigation_bar.dart';


void main() {
  runApp(App());
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        drawer: NavBar(),
      ),
    );
  }
}
