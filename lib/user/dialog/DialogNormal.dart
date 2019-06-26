import 'package:flutter/material.dart';
class DialogN extends StatefulWidget{
  final String titulo;
  final String mensaje;
  DialogN({Key key,this.titulo,this.mensaje}):
        super(key:key);
  DialogNState createState() => DialogNState();
}
class DialogNState extends State<DialogN>{
  String _titulo;
  String _mensaje;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titulo = widget.titulo;
    _mensaje = widget.mensaje;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      //backgroundColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(_titulo,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 10,),
            Text(_mensaje,
            style: TextStyle(
              fontSize: 16
            ),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}