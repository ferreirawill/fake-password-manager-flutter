

import 'package:flutter/material.dart';
import 'package:hello_world/blocs/upload_blocs.dart';

class UploadPass extends StatelessWidget {

  final _uploadBloc = UploadBloc();
  final _titleTextController = TextEditingController();
  final _userTextController = TextEditingController();
  final _passTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Center(
          child: Text("Almost There... :)"),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        BoxField(
          title: "Nome da aplicação",
          hint: "Digite o título",
          stream: _uploadBloc.outTitle,
          onChange: _uploadBloc.changeTitle,
          controller: _titleTextController,
        ),
        BoxField(
          title: "Usuário de login",
          hint: "Digite o usuário",
          stream: _uploadBloc.outUser,
          onChange: _uploadBloc.changeUser,
          controller: _userTextController,
        ),
        BoxField(
          title: "Senha cadastrada",
          hint: "Digite a senha",
          stream: _uploadBloc.outPass,
          onChange: _uploadBloc.changePass,
          controller: _passTextController,
        ),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Material(
            color: Color(0xFFA1CDF4),
            borderRadius:
            BorderRadius.all(Radius.circular(30.0)),
            elevation: 5.0,
            child: StreamBuilder(
              stream: _uploadBloc.outSubmit,
              builder: (context, snapshot) {
                return MaterialButton(
                  onPressed: snapshot.hasData ? (){
                    _uploadBloc.submit();
                    _titleTextController.clear();
                    _passTextController.clear();
                    _userTextController.clear();
                  } : null,
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text("Salvar"),
                );
              }
            )),
      ),
      ],
    ),
    );
  }
}




class BoxField extends StatelessWidget {
  final String title;
  final String hint;
  final stream;
  final onChange;
  final controller;

  BoxField({Key key, @required this.title, @required this.hint, @required this.stream, @required this.onChange, this.controller}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(title,style: TextStyle(
              fontSize: 22,
            ),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InputField(
                hint: hint,
                obscure: false,
                keyboard: TextInputType.visiblePassword,
                stream: stream,
                onChange: onChange,
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final keyboard;
  final stream;
  final onChange;
  final controller;


  InputField(
      {Key key,
        @required this.hint,
        @required this.obscure,
        @required this.stream,
        @required this.onChange,
        this.keyboard, this.controller,
      });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          decoration: InputDecoration(
            fillColor: Color(0xFFA0A5AF),
            hintText: hint,
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all((Radius.circular(32.0))),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all((Radius.circular(32.0))),
              borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all((Radius.circular(32.0))),
              borderSide: BorderSide(color:  Colors.lightBlue, width: 2.0),
            ),
          ),
          onChanged: (value){
            onChange.add(value);
          },
        );
      }
    );
  }
}
