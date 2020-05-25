import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Address extends StatefulWidget {

  _Address createState()=>_Address();
}

class _Address extends State<Address> {
  var _enterPhoneController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Addresses"),),
      body: Column(
        children: <Widget>[
            ListView.builder(itemBuilder: null)
          ] 
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
            
        },
        label: Text('New Address'),
        icon: Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),

      );
  }

}