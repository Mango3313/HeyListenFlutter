import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: ColorPrimario,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => Ingreso()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => Registro()));
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
class Registro extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro",textAlign: TextAlign.center,),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
class Ingreso extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingresar",textAlign: TextAlign.center,),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
