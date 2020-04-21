import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/upload_pass.dart';
import 'auth/auth_service.dart';
import 'password_screen.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final a = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "William Ferreira",
            ),
            accountEmail: Text("ferreirawill94@gmail.com"),
            currentAccountPicture: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage("images/will.jpeg"),
            ),
            decoration: BoxDecoration(color: Colors.blueGrey[900]),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Gerenciador'),
            onTap: () async {
              a.isBiometricAvailable();
              a.getListOfBiometricTypes();
              if(await a.authenticateUser()){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordScreen()));
              }
              else{

              }
            },
          ),
          ListTile(
            leading: Icon(Icons.cloud_upload),
            title: Text('Upload'),
            onTap: () async {
              a.isBiometricAvailable();
              a.getListOfBiometricTypes();
              if(await a.authenticateUser()){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPass()));
              }
              else{

              }

              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurar'),
            onTap: () {


              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
