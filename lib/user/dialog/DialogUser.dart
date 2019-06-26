import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../dialog/DialogNormal.dart';
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
    Uri datosAcUri = Uri.http("192.168.100.118:8008", "/user");
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
    return jsonDyn['message'];
  }
}