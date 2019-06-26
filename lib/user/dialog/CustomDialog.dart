import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';


class CustomDialog extends StatefulWidget {
  final Map<String,dynamic> mapa;
  //bool avisoSt = false;
  bool avisoEm = false;
  CustomDialog({Key key,this.mapa,
  }):super(key:key);
  DialogState createState() => DialogState();
}
class DialogState extends State<CustomDialog>{
  TextEditingController _controllerDesc = new TextEditingController();
  bool _avisoSt = false;
  bool _avisoEm = false;
  Map<String,dynamic> _mapa;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _avisoEm = widget.avisoEm;
    _mapa = widget.mapa;
    //_avisoSt = widget.avisoSt;
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: Consts.avatarRadius),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  "¿Que ha pasado?",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Emergencia"),
                        Checkbox(
                          activeColor: Colors.red,
                          value: _avisoEm,
                          onChanged: (bool value){
                            setState(() {
                              if(_avisoSt != true){
                                _avisoEm = value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text("Ingresa una descripción (Opcional):",
                  style: TextStyle(

                  ),
                ),
                TextFormField(
                  maxLines: 1,
                  controller: _controllerDesc,
                ),
                SizedBox(height: 15,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // To close the dialog
                        },
                        child: Text("Cancelar"),
                      ),
                      FlatButton(
                        onPressed: () {
                          _getDevPos().then((posicion){
                            Map<String,String> header = {
                              'Content-Type':'application/json',
                              'Authorization': "Bearer "+_mapa['token']
                            };
                            Map<String,dynamic> body = {
                              "descripcion": _controllerDesc.text,
                              "longitud":posicion.longitude,
                              "latitud":posicion.latitude,
                              "impacto":(_avisoEm)? 1 : 0,
                            };
                            debugPrint(jsonEncode(body).toString());
                            sendCoordenadas(header, jsonEncode(body)).then((rString){
                                Navigator.of(context).pop(); // To close the dialog
                            });
                          });
                        },
                        child: Text("Enviar"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: Consts.padding,
            right: Consts.padding,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: Consts.avatarRadius,
              child: Icon(
                Icons.announcement,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<Position> _getDevPos() async{
    Position usrPos = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
    return usrPos;
  }
  Future<String> sendCoordenadas(headerF,bodyF) async{
    Uri sendC = Uri.http("heylisten-mm.herokuapp.com", "report");
    Response response = await post(sendC,headers: headerF,body: bodyF);
    String r = response.body;
    debugPrint(r);
    return r;
  }
}
class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}