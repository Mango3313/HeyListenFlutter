import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import './dialog/DialogNormal.dart';

class DetalleReporte extends StatefulWidget{
  final String id;
  final String token;
  DetalleReporte({Key key,this.id,this.token}):super(key:key);
  StateDetReporte createState() => StateDetReporte();
}
class StateDetReporte extends State<DetalleReporte>{
  String _id;
  String _token;
  Reporte reporte;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _id = widget.id;
    _token = widget.token;
    getDetReporte(_id);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de reporte"),
      ),
      body: ListView(
        children: <Widget>[
          DrawerHeader(
            child: CircleAvatar(
              radius: 30.0,
              child:
              ClipOval(
                child: (reporte != null)?(reporte.impacto == 0)?Image.asset("assets/warning.png"):Image.asset("assets/siren.png"):Text("Cargando..."),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF448AFF),
            ),
          ),
          ListTile(
            title: Text("Descripción"),
            subtitle: (reporte!=null)?Text(reporte.descripcion):Text("Cargando..."),
          ),
          ListTile(
            title: Text("Fecha"),
            subtitle: (reporte!=null)?Text(reporte.fecha):Text("Cargando..."),
          ),
          ListTile(
            title: Text("ID del reporte"),
            subtitle: Text(_id),
          ),
          ListTile(
            onTap: (){
              eliminarReporte(_id).then((onValue){
                showDialog(context: context,builder: (BuildContext context)=>
                DialogN(titulo: "Mensaje",mensaje: (onValue!=null)?onValue:"Error, intente mas tarde",)).then((onValue){
                  Navigator.pop(context);
                });
              });
            },
            title: Text("Eliminar reporte",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
            ),
          )
        ],
      ),
    );
  }
  Future<String> eliminarReporte(id) async{
    //debugPrint("Token?"+_token);
    Map<String,String> header = {
      "Authorization":"Bearer "+_token,
    };
    Uri elimDet = Uri.http("heylisten-mm.herokuapp.com","/report/"+id);
    Response response = await delete(elimDet,headers: header);
    String respuesta = response.body;
    Map<String,dynamic> jsonResponse = jsonDecode(respuesta);
    return jsonResponse['message'];
  }
  Future<Reporte> getDetReporte(id)async{
    Uri uriDetalles = Uri.http("heylisten-mm.herokuapp.com","/report/"+id);
    Response response = await get(uriDetalles);
    String r = response.body;
    Map<String,dynamic> jsonResponse = jsonDecode(r);
    Reporte repActual = Reporte.readFromJson(jsonResponse);
    setState(() {
      reporte = repActual;
    });
    return repActual;
  }
}
class Reporte {
  final String id;
  final String descripcion;
  final int impacto;
  final double longitud;
  final double latitud;
  final String fecha;

  Reporte(this.id, this.descripcion, this.impacto, this.longitud, this.latitud,
      this.fecha);

  Reporte.readFromJson(Map<String, dynamic> json)
      :
        id = json['_id'],
        descripcion= json['descripcion'],
        impacto = json['impacto'],
        longitud = json['longitud'],
        latitud = json['latitud'],
        fecha = json['fecha'];

  Map<String, dynamic> toJson() =>
      {
        '_id': id,
        'descripcion': descripcion,
        'impacto': impacto,
        'longitud': longitud.toString(),
        'latitud': latitud.toString(),
        'fecha': fecha
      };
}