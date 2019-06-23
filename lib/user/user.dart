import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
void main() => runApp(MapApp());
MaterialColor ColorPrimario = const MaterialColor (0xFF3F51B5, const <int,Color>{
  50:const Color(0xFF3F51B5),
  100:const Color(0xFF3F51B5),
  200:const Color(0xFF3F51B5),
  300:const Color(0xFF3F51B5),
  400:const Color(0xFF3F51B5),
  500:const Color(0xFF3F51B5),
  600:const Color(0xFF3F51B5),
  700:const Color(0xFF3F51B5),
  800:const Color(0xFF3F51B5),
},
);
class MapApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hey, Listen!',
      initialRoute: "/",
      routes: {
        '/':(context) => MapInitial()
      },
      theme: ThemeData(
        primarySwatch: ColorPrimario,
      ),
    );
}
}
class MapInitial extends StatefulWidget{
  MapInitial({Key key,this.title}) : super(key:key);
  final String title;

  @override
  MapInitialState createState() => MapInitialState();
}
class MapInitialState extends State<MapInitial>{
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text("Drawer"),
                decoration: BoxDecoration(
                  color: Color(0xFF448AFF),
                ),
              ),
              ListTile(
                title: Text("Ubicaciones"),
                onTap: (){

                },
              ),
              ListTile(
                title: Text("Perfil"),
                onTap: (){

                },
              ),
              Divider(

              ),
              ListTile(
                title: Text("Configuración"),
                onTap: (){

                },
              ),
              ListTile(
                title: Text("Salir"),
                onTap: (){
                  
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Bienvenido'),
          backgroundColor: ColorPrimario,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}