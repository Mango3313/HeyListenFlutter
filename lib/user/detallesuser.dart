import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import './dialog/DialogNormal.dart';
import './dialog/DialogUser.dart';

class Perfil extends StatefulWidget{
  final Map<String,dynamic> datos;
  Perfil({Key key,this.datos}):super(key:key);
  @override
  PerfilState createState() => PerfilState();
}
class PerfilState extends State<Perfil>{
  Map<String,dynamic> _datos;
  String nombre;
  String nickname;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _datos = widget.datos;
    debugPrint("T1: "+_datos['token']);
    Map<String,String> header = {
      "Content-Type":"application/json",
      "Authorization":"Bearer "+_datos['token'],
    };
    debugPrint("H1: "+jsonEncode(header));
    getUsusrioDatos(header).then((onValue){
      setState(() {
        nombre = onValue.nombre;
        nickname = onValue.nickname;
      });
    }).catchError((error){
      showDialog(context: context,
          builder: (BuildContext context)=>
              DialogN(titulo: "Error",mensaje: error.toString(),)
      );
    });
  }
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
            subtitle: Text((nickname != null)? nickname:"No definido"),
          ),
          ListTile(
            title: Text("Nombre"),
            subtitle: Text((nombre != null)?nombre:"No definido"),
          ),
          ListTile(
            title: Text("Cambiar nickname",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            onTap: (){
              showDialog(context: context,
              builder: (BuildContext context) =>
                  DialogEditUser(token: _datos['token'],)
              );
            },
          ),
        ],
      ),
    );
  }
  Future<Usuario> getUsusrioDatos(header) async{
    debugPrint("Header: "+header.toString());
    Uri datosUri = Uri.http("heylisten-mm.herokuapp.com", "/user");
    Response response = await get(datosUri,headers: header);
    Map<String,dynamic> jsonRes = jsonDecode(response.body);
    //debugPrint("Nuevo json: "+jsonRes['datos_usuario']);
    Usuario usr = Usuario.fromJson(jsonRes['datos_usuario']);
    return usr;
  }
}
class Usuario{
  final String nombre;
  final String nickname;
  final String id;
  final String password;
  Usuario(this.nombre,this.nickname,this.id,this.password);
  Usuario.fromJson(Map<String,dynamic> json):
        nombre = json['nombre'],
        id = json['id'],
        nickname = json['nickname'],
  password = json['password'];
  Map <String, dynamic> toJson() =>
      {
        'nombre' : nombre,
        'password' : password,
        'id' : id,
        'nickname' : nickname,
      };
}