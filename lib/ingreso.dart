import 'package:flutter/material.dart';
class Ingreso extends StatefulWidget{
  @override
  IngresoState createState() => IngresoState();
}

class IngresoState extends State<Ingreso>{
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
                TextField(
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
                SizedBox(height: 15,),
                TextFormField(
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
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      color: Color(0xFF448AFF),
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/usuario');
                      },
                      child: Text("Listo",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}