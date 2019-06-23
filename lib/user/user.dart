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
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
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