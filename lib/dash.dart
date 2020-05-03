// import 'dart:convert';

import 'package:dex/dashBackground.dart';
import 'package:dex/dashBody.dart';
// import 'package:dex/product.dart';
import 'package:flutter/material.dart';

class Dash extends StatefulWidget {
  Dash({Key key}) : super(key: key);
  @override
  _Dash createState() => _Dash();
}
class _Dash extends State<Dash>{

                        

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       elevation: 0,
       leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.account_circle),
        onPressed: () { Scaffold.of(context).openDrawer(); },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    },
  ),
     ),
       body:Center(
        //  Base Column
       child:  Stack(
          children: <Widget>[
             DashBackground(),
             DashBody(),
          ],
       )
        ),
    );
 }
}

