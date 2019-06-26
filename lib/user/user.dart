import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import './dialog/CustomDialog.dart';
//void main() => runApp(MapApp());
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
  //final String datosApp;
  //MapApp(this.datosApp);
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
  final Map<String,dynamic> dataR;
  final String title;
  MapInitial({Key key,this.title,@required this.dataR}) : super(key:key);
  @override
  MapInitialState createState() => MapInitialState();
}
class MapInitialState extends State<MapInitial>{
  Map<String,dynamic> datosRe;
  @override
  void initState() {
    datosRe = widget.dataR;
    super.initState();
  }
  Future<void> permisos() async{
    GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
    if(geolocationStatus == GeolocationStatus.denied){
      PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]);
    }
  }
  GoogleMapController mapController;
  final LatLng _center = const LatLng(20.704070, -100.443852);
  //var location = new Location();
  var location = new Geolocator();
  Map<String, double> userLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(datosRe.toString());
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
              /**ListTile(
                leading: Icon(Icons.gps_fixed),
                title: Text("Ubicaciones"),
                onTap: (){
                  Navigator.pushNamed(context, '/usuario/ubicaciones');
                },
              ),**/
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
        body: Builder(builder: (context) => Center(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 18.0,
            ),
          ),
        ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 75,
          height: 75,
          child: FloatingActionButton(onPressed: (){
            //_getDevPos().then(
                //(onValue){
                  showDialog(context: context,
                    builder: (BuildContext context) => CustomDialog(mapa: datosRe,),
                  );
                //}
            //);
          },
            backgroundColor: Colors.red,
            mini: false,
            child: new Icon(Icons.warning,size: 30,),
          ),
        ),
      ),
    );
  }
  Future<List<Reporte>> getReportes(authToken) async{
    Uri ligaReportes =  Uri.http("heylisten-mm.herokuapp.com", "/user",authToken);

  }
}
class ListaReportes{
  Map<String,String> reportes;
  ListaReportes(this.reportes);
  //ListaReportes.fromJson(Map<String,dynamic> json):
      //json.forEach(f);
  //;
}
class Reporte{
  final String id;
  final String descripcion;
  final String impacto;
  final double longitud;
  final double latitud;
  final String fecha;

  Reporte(this.id,this.descripcion,this.impacto,this.longitud,this.latitud,this.fecha);

  Reporte.readFromJson(Map<String,String> json):
        id = json['_id'],
        descripcion= json['descripcion'],
        impacto = json['impacto'],
        longitud = int.parse(json['longitud']).toDouble(),
        latitud = int.parse(json['latitud']).toDouble(),
        fecha = json['fecha'];
  Map<String,String> toJson()=>{
    '_id': id,
    'descripcion': descripcion,
    'impacto': impacto,
    'longitud': longitud.toString(),
    'latitud':latitud.toString(),
    'fecha': fecha
  };
}