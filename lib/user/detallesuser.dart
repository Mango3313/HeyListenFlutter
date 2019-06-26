import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Perfil extends StatefulWidget{
  @override
  PerfilState createState() => PerfilState();
}
class PerfilState extends State<Perfil>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: ListView(
        children: <Widget>[
          DrawerHeader(
            child: CircleAvatar(
              radius: 30.0,
              child:
              ClipOval(
                child: Image.network("https://www.brighthope.org/wp-content/uploads/2018/09/goat.jpg"),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF448AFF),
            ),
          ),
          ListTile(
            title: Text("Nickname"),
            subtitle: Text("H4ilTo"),
          ),
          ListTile(
            title: Text("Usuario"),
            subtitle: Text("Zoila Cerda"),
          ),
          ListTile(
            title: Text("Cambiar nickname",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            onTap: (){

            },
          ),
        ],
      ),
    );
  }
}