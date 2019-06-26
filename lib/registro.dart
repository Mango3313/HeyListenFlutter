import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Registro extends StatefulWidget{
  @override
  RegistroState createState() => RegistroState();
}

class RegistroState extends State<Registro>{
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final _nombreController = TextEditingController();
  final _nombreKey = GlobalKey<FormState>();
  final _nickController = TextEditingController();
  final _nickKey = GlobalKey<FormState>();
  final _telefonoController = TextEditingController();
  final _telefonoKey = GlobalKey<FormState>();
  final _contraController = TextEditingController();
  final _contraKey = GlobalKey<FormState>();
  final _rcontraController = TextEditingController();
  final _rcontraKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro",textAlign: TextAlign.center,),
      ),
      body: ListView(
        children: <Widget>[
          Center(
              child: Padding(padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Ingrese los datos que se le piden a continuación:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 15,),
                    Form(
                      key: _nombreKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value){
                              if(value.isEmpty){
                                return "El campo no puede estar vacio";
                              }else{
                                return null;
                              }
                            },
                            controller: _nombreController,
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
                                hintText: "Nombre",
                                fillColor: Color(0xFFEDEDED)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Form(
                      key: _nickKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value){
                              if(value.isEmpty){
                                return "El campo no puede estar vacio";
                              }else{
                                return null;
                              }
                            },
                            controller: _nickController,
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
                                hintText: "Nickname",
                                fillColor: Color(0xFFEDEDED)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Form(
                      key: _telefonoKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value){
                              if(value.isEmpty){
                                return "El campo no puede estar vacio";
                              }else{
                                return null;
                              }
                            },
                            controller: _telefonoController,
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
                                hintText: "Telefono",
                                fillColor: Color(0xFFEDEDED)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Form(
                      key: _contraKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value){
                              if(value.isEmpty){
                                return "El campo no puede estar vacio";
                              }else{
                                return null;
                              }
                            },
                            controller: _contraController,
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
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Form(
                      key: _rcontraKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value){
                              if(value.isEmpty){
                                return "El campo no puede estar vacio";
                              }else{
                                return null;
                              }
                            },
                            controller: _rcontraController,
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
                                hintText: "Repetir Contraseña",
                                fillColor: Color(0xFFEDEDED)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Builder(
                          builder: (context)=>
                              RaisedButton(
                                color: Color(0xFF448AFF),
                                onPressed: (){
                                  if(_nombreKey.currentState.validate() &&
                                      _nickKey.currentState.validate() &&
                                      _telefonoKey.currentState.validate()&&
                                      _contraKey.currentState.validate()&&
                                      _rcontraKey.currentState.validate()){
                                    bool resValCont = validarContrasenia();
                                    String mensaje = "";
                                    (resValCont)? mensaje = "Validando": mensaje = "Error, las contraseñas no coinciden";
                                    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(mensaje),));
                                    if(resValCont){
                                      Usuario usr = Usuario(_nombreController.text, _nickController.text, _telefonoController.text, _contraController.text);
                                      Map<String,String> datos = usr.toJson();
                                      debugPrint(Usuario.fromJson(datos).nickname);
                                      enviarPeticion(datos).then((onValue){
                                        //debugPrint(onValue);
                                          final cuerpoResp = jsonDecode(onValue);
                                          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(cuerpoResp['message']),));
                                      });
                                    }
                                  }
                                },
                                child: Text("Listo",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
  bool validarContrasenia(){
    bool resultado = false;
    (_contraController.text == _rcontraController.text) ?  resultado = true :  resultado = false ;
    return resultado;
  }
  Future <String> enviarPeticion(Cuerpo) async{
    Uri uriAlta = new Uri.http("10.16.27.38:8008", "/user");
    debugPrint(Cuerpo.toString());
    Response response = await post(uriAlta,body: Cuerpo).timeout(const Duration(seconds: 10));
    String respuesta = response.body;
    debugPrint('Respuesta!! '+respuesta);
    return respuesta;
  }
}
class Usuario{
  final String nombre;
  final String nickname;
  final String telefono;
  final String password;
  Usuario(this.nombre,this.nickname,this.telefono,this.password);
  Usuario.fromJson(Map<String,String> json):
        nombre = json['nombre'],
        password = json['password'],
        telefono = json['telefono'],
        nickname = json['nickname'];
  Map <String, String> toJson() =>
      {
        'nombre' : nombre,
        'password' : password,
        'telefono' : telefono,
        'nickname' : nickname,
      };
}