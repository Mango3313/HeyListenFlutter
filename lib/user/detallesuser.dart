import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import './dialog/DialogNormal.dart';

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
              Map<String,String> header = {
                "Content-Type":"application/json",
                "Authorization":"Bearer "+_datos['token'],
              };
              getUsusrioDatos(header).then((onValue){
                setState(() {
                  nombre = onValue.nombre;
                  nickname = onValue.nickname;
                });
              });
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
class DialogEditUser extends StatefulWidget{
  final String token;
  //final String mensaje;
  DialogEditUser({Key key,this.token//,this.mensaje
  }):
        super(key:key);
  DialogEditState createState() => DialogEditState();
}
class DialogEditState extends State<DialogEditUser>{
  String _token;
  String _mensaje;
  TextEditingController _controlNombre = new TextEditingController();
  TextEditingController _controlPassword = new TextEditingController();
  TextEditingController _controlNPassword = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _token = widget.token;
    // _mensaje = widget.mensaje;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      //backgroundColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Editar información",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _controlNombre,
              decoration: InputDecoration(
                  labelText: "Nombre",
                  hintText: "P@sword"
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _controlPassword,
              decoration: InputDecoration(
                  labelText: "Contraseña",
                  hintText: "P@sword"
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _controlNPassword,
              decoration: InputDecoration(
                  labelText: "Nueva Contraseña",
                  hintText: "P@sword"
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: (){
                    debugPrint(_token);
                    updateUsuarioDatos(_token, _controlNombre.text, _controlPassword.text, _controlNPassword.text).then((onValue){
                      Navigator.of(context).pop();
                      debugPrint(onValue);
                      showDialog(
                        context: context,
                        builder:(BuildContext context)=>
                            DialogN(
                              titulo: "Atención",
                              mensaje: onValue,
                            ),
                      );
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<String> updateUsuarioDatos(String token,String nombre,String password,String nPassword)async{
    //TODO: actualizar datos
    debugPrint(token);
    Uri datosAcUri = Uri.http("heylisten-mm.herokuapp.com", "/user");
    Map<String,String> header={
      'Content-Type':'application/json',
      'Authorization': "Bearer "+token,
    };
    Map<String,dynamic> body = {
      "nombre": nombre,
      "password": password,
      "new_password":nPassword,
    };
    Response response = await put(datosAcUri,headers: header,body:jsonEncode(body));
    Map<String,dynamic> jsonDyn = jsonDecode(response.body);
    if(jsonDyn.containsKey('message')){
      return jsonDyn['message'];
    }
    else{
      setState(() {
        //_token = jsonDyn["token"];
      });
      return "Datos cambiados con exito";
    }

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