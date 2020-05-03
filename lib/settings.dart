import 'package:dex/textBox.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings>{

    
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  TextStyle _valuefont  =  new TextStyle(fontFamily: "roboto",fontSize:15);
  TextStyle _namefont  =  new TextStyle(fontFamily: "roboto",fontSize:24);

  TextBoxer m = new TextBoxer(labelText:"m");
  TextBoxer m1 = new TextBoxer(labelText:"m1");
  TextBoxer m2 = new TextBoxer(labelText:"");
  TextBoxer m3 = new TextBoxer(labelText:"");
  TextBoxer m4 = new TextBoxer(labelText:"");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Settings"),
      ),
        body: Container(
          child: 
          Center(
            child: Column(
              children: <Widget>[
                Expanded(flex:5,child: m),
                Expanded(child: m1),
              ], 
             ),
            ),
          ),
        );
       
  }
}
