import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

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
    getUsusrioDatos(_datos['token']).then((onValue){
      nombre = onValue.nombre;
      nickname = onValue.nickname;
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

            },
          ),
        ],
      ),
    );
  }
  Future<Usuario> getUsusrioDatos(String token) async{
    debugPrint("Token: "+token);
    Uri datosUri = Uri.http("heylisten-mm.herokuapp.com", "/user");
    Map<String,String> header = {
      //"Content-Type":"application/x-www-form-urlencoded",
      "Authentication":"Bearer "+token,
    };
    Response response = await get(datosUri,headers: header);
    Map<String,dynamic> jsonRes = jsonDecode(response.body);
    debugPrint(response.body);
    Usuario usr = Usuario.fromJson(jsonRes['datos_usuario']);
    return usr;
  }
  Futu
}
class Usuario{
  final String nombre;
  final String nickname;
  final int id;
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