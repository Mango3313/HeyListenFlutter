import 'package:flutter/material.dart';

class Ubicaciones extends StatefulWidget{
  @override
  StateUbicaciones createState() => StateUbicaciones();
}
class StateUbicaciones extends State<Ubicaciones>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis ubicaciones"),
      ),
      body:
      ListView(
        children: <Widget>[
          ListTile(
            title: Text("Ubicacion 1"),
            trailing: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}