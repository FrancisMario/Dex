import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dex/base.dart';
import 'package:dex/dataStructures.dart';
import 'package:dex/database.dart';
import 'package:dex/login.dart';
import 'package:path/path.dart';
import 'package:dex/appState.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';



class Setup extends StatefulWidget{
   Setup({Key key}) : super(key: key);
   @override
   _Setup createState() => _Setup();
}

class _Setup extends State<Setup>{
  
    // checking if the phone has an active accont registered to it
Future<dynamic> checkingUserLoginState() async {
  // Checking if the database is  
  var bol = await  databaseExists(join(await getDatabasesPath(), "state"));
  if (bol) {
    // opening the database  
    Database db = await  openDatabase( join(await getDatabasesPath(), "state"),version: 1,onOpen: (db){
        //  So creating databases          
        print("databases exist");
    });
    // running query to see if the database has anything
    dynamic  query = await db.rawQuery("SELECT * FROM credential;");
      // making sure query worked
      if (query != null) {
        // 
        if (query.length > 0) {
          String json = '{"user_id":"${query[0]['user_id']}","name":"${query[0]['name']}","phone":"${query[0]['phone']}"}';
          return json;
        } else {
          print("query != null");
          print(query);
          print(bol);
          // if the locally stored data is null the show the network error screen.
          return null;
        }
      } else {
        //Query didn't worked.
        print("table doesn't exist");
        return null;
      }
  } else {
    // database didn't exist, Creating....

      Database db = await  openDatabase( join(await getDatabasesPath(), "state"),version: 1,onCreate: (db,version) async {
        //  So creating tables  
                  await db.execute(" create table `credential` (user_id text not null ,name text, phone text not null )");
                  await  db.execute(" create table `stat` ( total_delivery text not null, account_type text not null) ");
                  await db.execute(" create table `address` ( table_id integer primary key autoincrement, name text not null, street text not null, geo_coordinate text not null) ");
                  await db.execute(" create table `record` ( time text not null, date text not null, pickup text not null, packageType text not null, destination text not null, reciever text not null)");
                  await db.execute(" create table `hashes` ( datatype text not null, last_update text not null, hash text not null)");
        print("Created all new databases");
    });
    print("database didn't exist but just created one.");
    return null;
  }
}
    

    @override
  Widget build(BuildContext context) {
      Provider.of<AppState>(context, listen: true);
    return Scaffold(
      body: Center(
        child: FutureBuilder<dynamic>(
          ///If future is null then API will not be called as soon as the screen
          ///loads. This can be used to make this Future Builder dependent
          ///on a button click.
          future: checkingUserLoginState(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
                ///when the future is null
              case ConnectionState.none:
                return Text(
                  'Press the button to fetch data',
                  textAlign: TextAlign.center,
                );

              case ConnectionState.active:

                ///when data is being fetched
              case ConnectionState.waiting:
                return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));

              case ConnectionState.done:
                ///task is complete with an error (eg. When you
                ///are offline)
                if (snapshot.hasError){
                  print("snapshot has error");
                  print(snapshot.error);
                      return  Login();
                } else {
                    if (snapshot.data == null) {
                      print("no data in database");
                      return  Login();
                    } else {
                      if (true) { 
                        // if the data is from the local database
                        print(snapshot.data);
                        Map<String, dynamic> data = jsonDecode(snapshot.data);
                        Credential cred = new Credential.fromJson(data);
                        Provider.of<AppState>(context, listen: true).setCred(cred,false);
                      } else {
                         /**
                          * I have no idea why i wrote this else block. Maybe it's important, 
                          * so i won't delete it.
                          */
                         // if the data is from remote server
                      Provider.of<AppState>(context, listen: true).setCred(snapshot.data,false);
                      }
                      return  Home();
                    }
                }
            }
          },
        ),
      ));
  }
}
    
