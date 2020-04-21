
import 'dart:async';
import 'dart:math';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:hello_world/database/database.dart';
import 'package:rxdart/rxdart.dart';

class UploadBloc extends BlocBase{

  final _titleController = BehaviorSubject<String>();
  final _userController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();

  Stream<String> get outTitle => _titleController.stream.transform(validateTitle);
  Stream<String> get outUser => _userController.stream.transform(validateUser);
  Stream<String> get outPass => _passController.stream.transform(validatePass);

  Sink get changeTitle => _titleController.sink;
  Sink get changeUser => _userController.sink;
  Sink get changePass => _passController.sink;

  Stream<bool> get outSubmit => Observable.combineLatest3(outTitle, outUser, outPass, (a, b, c) => true);

  String _title;
  String _user;
  String _pass;

  UploadBloc(){
    outTitle.listen((event) {
      _title = event;
    });
    outUser.listen((event) {
      _user = event;
    });
    outPass.listen((event) {
      _pass = event;
    });
  }

  Future<void> submit() async {
    print("Submissao ocooreu");
    final key = Key.fromUtf8("Prime!roD!aDe&mprego&m13092017..");
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));


    final encryptedUser = encrypter.encrypt(_user, iv: iv);
    final encryptedPass = encrypter.encrypt(_pass, iv: iv);

    print(_title);
    print(_user);
    print(encryptedUser.base64);
    print(_pass);
    print(encryptedPass.base64);

    DBProvider.db.newPassword({
      "title": _title,
      "user":encryptedUser.base64,
      "password":encryptedPass.base64,
    });
    try{
      Firestore.instance.collection("WillInfo").document(_title).setData({
        "title": _title,
        "login": encryptedUser.base64,
        "password": encryptedPass.base64,
      });
    }catch(e){
      print(e);
    }
    _pass= "";
    _user="";
    _title="";



  }

  final validateTitle = StreamTransformer<String,String>.fromHandlers(handleData: (title,sink){
    if(title != null){
      sink.add(title);
    }else{
      sink.addError("Campo esta nulo");
    }
  });

  final validateUser = StreamTransformer<String,String>.fromHandlers(handleData: (user,sink){
    if(user != null){
      sink.add(user);
    }else{
      sink.addError("Campo esta nulo");
    }
  });

  final validatePass = StreamTransformer<String,String>.fromHandlers(handleData: (pass,sink){
    if(pass != null){
      sink.add(pass);
    }else{
      sink.addError("Campo esta nulo");
    }
  });
  
  @override
  void dispose() {
    _titleController.close();
    _userController.close();
    _passController.close();

  }


}