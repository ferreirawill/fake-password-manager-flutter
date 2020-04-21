import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'blocs/read_blocs.dart';
import 'database/database.dart';

class PasswordScreen extends StatelessWidget {
  final _readBlocs = ReadBlocs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          actions: <Widget>[
            IconButton(icon: Icon(Icons.sync),
                onPressed: (){
              _readBlocs.sync();
                })
          ],
        ),
        body: StreamBuilder<List<Map<String,dynamic>>>(
          stream: _readBlocs.outData,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.length == 0){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage("images/padloc.png"),),
                    Text("Não há dados salvos. :(",style: TextStyle(fontSize: 25,fontFamily:"ubuntu",fontWeight: FontWeight.w300),)
                  ],
                );
              }
              else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Cards(title: snapshot.data[index]["title"],
                      user: snapshot.data[index]["user"],
                      password: snapshot.data[index]["password"],
                      id: snapshot.data[index]["id"],);
                  },
                );
              }
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }
        ),
    );
  }
}

class Cards extends StatelessWidget {
  final String title;
  final String user;
  final String password;
  final int id;

  const Cards({Key key, this.title, this.user, this.password, this.id}) : super(key: key);

  Future<void> OpenDialog(context){
    showDialog(context: context,
    builder: (BuildContext context){
      return SimpleDialog(
        title: Text("Está certo disso?"),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Se clicar em sim, você apagará este registro."),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  color: Colors.blueGrey,
                  child: Text("Sim",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    DBProvider.db.deletePassword(id);
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                width: 65,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  color: Colors.blueGrey,
                  child: Text("Não",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onDoubleTap: (){
          print("Double Tapped");
          OpenDialog(context);
          //DBProvider.db.deletePassword(id);
        },
        child: Card(
          color: Colors.blueGrey[50],
          child: Padding(
            padding: EdgeInsets.only(
                top: 10.0, left: 6.0, right: 6.0, bottom: 6.0),
            child: ExpansionTile(
              title: Text(title,style: TextStyle(fontSize: 20,),),

              children: <Widget>[
                Text("User: $user",style: TextStyle(fontSize: 18),),
                Text("Password: $password",style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

