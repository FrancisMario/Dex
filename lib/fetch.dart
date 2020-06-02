import 'dart:async';
import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/dataStructures.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';



Future<Credential> fetchCredential(BuildContext context,String phone) async {
        String url =Provider.of<AppState>(context, listen: false).serverUrl; 
  final response =
      await http.get( url + '?user_id=${phone}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Credential.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Stat> fetchStat() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Stat.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}



Future<Record> fetchRecord() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Record.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<OrderPackage> fetchAddress() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    // return OrderPackage.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}