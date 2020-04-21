
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:hello_world/database/database.dart';
import 'package:rxdart/rxdart.dart';


class ReadBlocs extends BlocBase{

  final _dataController = BehaviorSubject<List<Map<String,dynamic>>>();

  Stream get outData => _dataController.stream;

  ReadBlocs(){
    getAll();
  }

  getAll() async {
    var data = await DBProvider.db.getAllPasswords();
    final key = Key.fromUtf8("Prime!roD!aDe&mprego&m13092017..");
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    List<Map<String, dynamic>> _decryptedList = [];

    data.forEach((element) {
      _decryptedList.add({
        "id": element["id"],
        "title": element["title"],
        "user": encrypter.decrypt64(element["user"], iv: iv),
        "password": encrypter.decrypt64(element["password"], iv: iv),
      });

    });
    _dataController.sink.add(_decryptedList);
  }

  @override
  void dispose() {
    _dataController.close();
  }

  sync() async {
    final snapshot = await Firestore.instance.collection("WillInfo").getDocuments();

    final syncData = snapshot.documents;
    var data = await DBProvider.db.getAllPasswords();

    syncData.forEach((element) {
        print("Title: ${element["title"]}");
        print("User: ${element["login"]}");
        print("Password: ${element["password"]}");


        DBProvider.db.newPassword({
          "title": element["title"],
          "user":element["login"],
          "password":element["password"],
        });

    });


  }

}