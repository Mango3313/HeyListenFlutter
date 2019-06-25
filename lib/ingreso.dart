import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
class Ingreso extends StatefulWidget{
  @override
  IngresoState createState() => IngresoState();
}

class IngresoState extends State<Ingreso>{
  final _nickIController = TextEditingController();
  final _nickIKey = GlobalKey<FormState>();
  final _contraIController = TextEditingController();
  final _contraIKey = GlobalKey<FormState>();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingresar",textAlign: TextAlign.center,),
      ),
      body: Center(
          child: Padding(padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                // SizedBox(height: 100,),
                Text(
                  "Ingrese usuario y contraseña",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
                SizedBox(height: 15,),
                Form(
                  key: _nickIKey
                ,child:  TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return "El campo no puede estar vacio";
                    }else{
                      return null;
                    }
                  },
                  controller: _nickIController,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEDEDED), width: 0.0),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(5.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "Correo",
                      fillColor: Color(0xFFEDEDED)),
                ),
                ),
                SizedBox(height: 15,),
                Form(
                  key: _contraIKey,
                  child: TextFormField(
                    validator: (value){
                      if(value.isEmpty){
                        return "El campo no puede estar vacio";
                      }else{
                        return null;
                      }
                    },
                    controller: _contraIController,
                    obscureText: _obscureText,
                    decoration: new InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: _toggle,
                        ),
                        border: new OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFEDEDED), width: 0.0),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: "Contraseña",
                        fillColor: Color(0xFFEDEDED)),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Builder( builder: (context)=>
                        RaisedButton(
                          color: Color(0xFF448AFF),
                          onPressed: (){
                            if(_nickIKey.currentState.validate() && _contraIKey.currentState.validate()){
                              //Credenciales datos = Credenciales(_nickIController.text,_contraIController.text);
                              //verificarCredenciales(datos.toJson()).then((onValue){
                                //if(onValue.isEmpty){
                                  //debugPrint("Mensaje vacio");
                                //}else{
                                  //final cuerpoResp = jsonDecode(onValue);
                                  //if(cuerpoResp['token']){
                                    Navigator.pushReplacementNamed(context, '/usuario');
                                  //}else{
                                    //Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(cuerpoResp['message']),));
                                  //}
                                //}
                              //}
                           //);
                            }
                          },
                          child: Text("Listo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
  Future<String> verificarCredenciales(datosAcceso) async{
    Uri uriAlta = new Uri.http("192.168.100.115:8000", "/login",datosAcceso);
    Response response = await post(uriAlta).timeout(const Duration(seconds: 2));
    String respuesta = response.body;
    debugPrint('Respuesta!! '+respuesta);
    return respuesta;
  }
}
class Credenciales{

  final String nickname;
  final String password;
  Credenciales(this.nickname,this.password);
  Credenciales.fromJson(Map<String,String> json):

        password = json['password'],

        nickname = json['nickname'];
  Map <String, String> toJson() =>
      {
        'password' : password,
        'nickname' : nickname,
      };
}