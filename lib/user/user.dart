import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
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
  Future<bool> permisos() async{
    GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
    debugPrint(geolocationStatus.toString());
    return false;
  }
  GoogleMapController mapController;
  final LatLng _center = const LatLng(20.704070, -100.443852);
  //var location = new Location();
  Map<String, double> userLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    permisos();
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: CircleAvatar(
                  radius: 30.0,
                  child: ClipOval(
                    child: Image.network("https://www.brighthope.org/wp-content/uploads/2018/09/goat.jpg"),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF448AFF),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Perfil"),
                onTap: (){
                  Navigator.pushNamed(context, '/usuario/profile');
                },
              ),
              ListTile(
                leading: Icon(Icons.gps_fixed),
                title: Text("Ubicaciones"),
                onTap: (){
                  Navigator.pushNamed(context, '/usuario/ubicaciones');
                },
              ),
              Divider(

              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Salir"),
                onTap: (){
                  Navigator.pop(context);
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
            zoom: 18.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 75,
          height: 75,
          child: FloatingActionButton(onPressed: (){},
            backgroundColor: Colors.red,
            mini: false,
            child: new Icon(Icons.warning,size: 30,),
          ),
        ),
      ),
    );
  }
}

class Perfil extends StatefulWidget{
  @override
  PerfilState createState() => PerfilState();
}
class PerfilState extends State<Perfil>{
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
            title: Text("Usuario"),
            subtitle: Text("Zoila Cerda"),
          ),
          ListTile(
            title: Text("Cambiar usuario",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            onTap: (){

            },
          ),
        ],
      ),
    );
  }
}
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