import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart';
import './dialog/CustomDialog.dart';
import './detallesuser.dart';
import 'dart:convert';
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
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  @override
  void initState() {
    datosRe = widget.dataR;
    getReportes(datosRe['token']).then((onValue){
      debugPrint(onValue.toString());
      setState(() {
        markers = onValue;
      });
    });
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
                  Navigator.push(context, new MaterialPageRoute(builder: (builder)=>
                  Perfil(datos: datosRe,)));
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
            markers: Set<Marker>.of(markers.values),
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
                  ).then((Dinamico){
            getReportes(datosRe['token']).then((onValue){
              debugPrint(onValue.toString());
              setState(() {
                markers = onValue;
              });
            });
                  });
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
  Future<Map<MarkerId, Marker>> getReportes(authToken) async{
    Uri ligaReportes =  Uri.http("heylisten-mm.herokuapp.com", "/report");
    Response res = await get(ligaReportes);
    //Future<BitmapDescriptor> returnValue = _createMarkerImageFromAsset("assets/siren.png");
    Map<MarkerId, Marker> reporte = {};
    List<dynamic> jArray = jsonDecode(res.body);
    jArray.forEach((v){
      Reporte r = new Reporte.readFromJson(v);
      MarkerId marker = new MarkerId(r.id);
      reporte[marker] = new Marker(
        //icon: returnValue,
        markerId: marker,
        position: new LatLng(r.latitud, r.longitud),

      );//LatLng(r.latitud, r.longitud);
    });
    return reporte;
  }
  /**Future <BitmapDescriptor> _createMarkerImageFromAsset(String iconPath) async {
       ImageConfiguration configuration = ImageConfiguration();
                  BitmapDescriptor bmpd = await BitmapDescriptor.fromAssetImage(
                  configuration, iconPath);return bmpd;
      }
      **/
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
  final int impacto;
  final double longitud;
  final double latitud;
  final String fecha;

  Reporte(this.id,this.descripcion,this.impacto,this.longitud,this.latitud,this.fecha);

  Reporte.readFromJson(Map<String,dynamic> json):
        id = json['_id'],
        descripcion= json['descripcion'],
        impacto = json['impacto'],
        longitud = json['longitud'],
        latitud = json['latitud'],
        fecha = json['fecha'];
  Map<String,dynamic> toJson()=>{
    '_id': id,
    'descripcion': descripcion,
    'impacto': impacto,
    'longitud': longitud.toString(),
    'latitud':latitud.toString(),
    'fecha': fecha
  };
}