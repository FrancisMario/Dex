import 'package:flutter/material.dart';

class DashBackground extends StatefulWidget {
   DashBackground({Key key}) : super(key: key);
@override
_DashBackground  createState() => _DashBackground();
}

class _DashBackground extends State<DashBackground>{

  @override
  Widget build(BuildContext context) {

    return Container(
      child:Column( 
        children:<Widget> [
          // Blue
        // Padding(padding: EdgeInsets.only(top:4)),
        Expanded(
          flex: 4,
            child: Container(
            color: Colors.red,
          ),
        ),

        // White
        Padding(padding: EdgeInsets.only(top:4)),
          Expanded(
            flex: 5,
            child: Container(
            color: Colors.white,

          ),
        ),       
      ]

      ) 
      ,);
  }
  
}