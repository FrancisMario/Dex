
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class ConnectionErrors {

  Widget connectionUnavailable(){
    BuildContext context;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text("Connection unavailable"),
      ),
    );
  }  
}