import 'package:flutter/material.dart';
import './user/user.dart';
import './registro.dart';
import './ingreso.dart';
import './user/detallesuser.dart';
import './user/ubicacionesuser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hey, Listen!',
      initialRoute: "/",
      routes: {
        '/':(context) => MyHomePage(),
        '/Registro': (context) => Registro(),
        '/Ingreso':(context) => Ingreso(),
        '/usuario':(context)=>MapInitial(),
        '/usuario/profile':(context)=> Perfil(),
        '/usuario/ubicaciones':(context)=> Ubicaciones()
      },
      theme: ThemeData(
        primarySwatch: ColorPrimario,
      ),
    );
  }
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
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3F51B5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: new AssetImage("assets/mapa_splash.png"),
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
            SizedBox(
              height: 20,
            )
            ,
            Text(
              'Hey, Listen!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )
            ,
            SizedBox(height: 200,)
            ,
            RaisedButton(
              color: Color(0xFF448AFF),
              padding: EdgeInsets.only(left: 45 ,top: 10 ,right:45 ,bottom:10 ),
              onPressed: (){

                Navigator.pushNamed(context,'/Ingreso');
              },
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: Text(
                  'Ingresar',
                  style: TextStyle(fontSize: 24,
                  color: Colors.white)
              ),
            ),
            SizedBox(height: 15,),
            RaisedButton(
              color: Color(0xFF448AFF),
              padding: EdgeInsets.only(left: 35 ,top: 10 ,right:35 ,bottom:10 ),
              onPressed: (){
                Navigator.pushNamed(context,'/Registro');
              },
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 16,
                      color: Colors.white)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
