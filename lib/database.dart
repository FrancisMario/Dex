import 'dart:async';

import 'package:dex/dataStructures.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {

Database database;
String dbName = "state";

      Future  Open() async{ 
        openDatabase(
               // Set the path to the database. Note: Using the `join` function from the
               // `path` package is best practice to ensure the path is correctly
                // constructed for each platform.
               join(await getDatabasesPath(), dbName),version: 1,onCreate: (db , version) async {
                  await db.execute(" create table `credential` ( name text not null, phone text not null )");
                  await db.execute(" create table `stat` ( total_delivery text not null, account_type text not null) ");
                  await db.execute(" create table `address` ( table_id integer primary key autoincrement, name text not null, street text not null, geo_coordinate text not null) ");
                  await db.execute(" create table `record` ( time text not null, date text not null, pickup text not null, packageType text not null, destination text not null, reciever text not null)");
                  await db.execute(" create table `hashes` ( datatype text not null, last_update text not null, hash text not null)");
                  },onOpen: (db){
                    // db.rawQuery("INSERT INTO credential (name,phone)  VALUES ('mario','3247034')");
                     db.execute(" create table `credential` ( name text not null, phone text not null )");
                     db.execute(" create table `stat` ( total_delivery text not null, account_type text not null) ");
                    db.execute(" create table `address` ( table_id integer primary key autoincrement, name text not null, street text not null, geo_coordinate text not null) ");
                    db.execute(" create table `record` ( time text not null, date text not null, pickup text not null, packageType text not null, destination text not null, reciever text not null)");
                     db.execute(" create table `hashes` ( datatype text not null, last_update text not null, hash text not null)");
                  }
                 );
        } 



        InsertCredential(Credential cred) async{
          final Database db = await  openDatabase(join(await getDatabasesPath(), dbName),version: 1,);
          await db.insert(
              'credential',
              cred.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace,
          );
          
        }

        InsertStat(Stat stat) async{
          final Database db = await database;
            await db.insert(
                'stat',
                stat.toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace,
            );
        }

        InsertAddress(Address address) async{
          final Database db = await database;
            await db.insert(
                'address',
                address.toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace,
            );
        }


         InsertRecord(Record record) async{
          final Database db = await database;
            await db.insert(
                'record',
                record.toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace,
            );
        }



Future<List<Address>> GetAddress(int mode,String searchParam) async{
    final Database db = await database;
              // Query the table for all The Address.
    final List<Map<String, dynamic>> maps = await db.query('state');

  // Convert the List<Map<String, dynamic> into a List<Addresses>.
      return List.generate(maps.length, (i) {
        return Address(
          name: maps[i]['name'],
          description: maps[i]['description'],
          geolocation: maps[i]['geolocation'],
        );
      });
           
        }

Future<List<Stat>> GetStats() async{
    final Database db = await database;
              // Query the table for all The Address.
    final List<Map<String, dynamic>> maps = await db.query('state');

  // Convert the List<Map<String, dynamic> into a List<Addresses>.
      return List.generate(maps.length, (i) {
        return Stat(
          totalDelivery: maps[i]['totalDelivery'],
          accountType: maps[i]['accountType'],
          accountOwner: maps[i]['accountOwner'],
        );
      });
}





Future<List<Record>> GetRecords() async{
    final Database db = await database;
              // Query the table for all The Address.
    final List<Map<String, dynamic>> maps = await db.query('state');

  // Convert the List<Map<String, dynamic> into a List<Addresses>.
      return List.generate(maps.length, (i) {
        return Record(
          
          time: maps[i]['time'],
          date: maps[i]['date'],
          name: maps[i]['name'],
          contact: maps[i]['contact'],
          address: maps[i]['address']
        );
      });
}



Future<List<Credential>> GetCredential() async {
    final Database db = await database;
              // Query the table for all The Address.
    final List<Map<String, dynamic>> maps = await db.query('state');

  // Convert the List<Map<String, dynamic> into a List<Addresses>.
      return List.generate(maps.length, (i) {
        return Credential(
          phone: maps[i]['phone'],
          // sessKey: maps[i]['sessKey'],
          name: maps[i]['name'],
          // deviceId: maps[i]['deviceId']
        );
      });
}





   Future GetPhone() async {
            openDatabase(
               join(await getDatabasesPath(), dbName),version: 1,
            ).then((db){
              Future <List<Map<String, dynamic>>>  query = db.rawQuery("SELECT * FROM credential LIMIT 1;");
               query.then((onValue){
                 print(onValue);
               });
            });
      print('awa query');
      print("query");
   }

}