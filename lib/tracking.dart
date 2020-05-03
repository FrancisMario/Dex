import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/dataStructures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Tracking extends StatefulWidget {
  Tracking(Key key) : super(key: key);
  @override
  _Tracking createState()=>_Tracking();
}
         

class _Tracking extends State<Tracking> {

  TextStyle _namefont  =  new TextStyle( fontFamily: "roboto",fontSize:24);
  TextStyle _valuefont  =  new TextStyle(fontFamily: "roboto",fontSize:15);


  @override 
  Widget build(BuildContext context) {
    
    return Container(
      child:ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
            Padding(padding: EdgeInsets.only(top:50)),
            Padding(padding: EdgeInsets.only(right:10)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[ 
                     DeliveryList(widget.key),
               ]
              ),          
             ]
            ), 
          );
        }

}

class DeliveryList extends StatelessWidget{

  DeliveryList(Key key) : super(key: key);

  Future<List<dynamic>> getList(BuildContext context) async{
    // String usr_id = Provider.of<AppState>(context, listen: true).cred.phone;
        final response = await http.get('http://192.168.0.15/records/get_records.php?user_id=');
        return jsonDecode(response.body) ;
  }

 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            child: FutureBuilder<List<dynamic>>(
          ///If future is null then API will not be called as soon as the screen
          ///loads. This can be used to make this Future Builder dependent
          ///on a button click.
          future: getList(context),
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
                return Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
                  ),
                );

              case ConnectionState.done:
                ///task is complete with an error (eg. When you
                ///are offline)
                if (snapshot.hasError){
                  print("snapshot has error");
                  print(snapshot.error);
                      return  Text("Error/n" + snapshot.error);
                } else {
                    if (snapshot.data == null) {
                      print("no data in database");
                      return  Text("NO ONGOING DELIVERIES");
                    } else {
                      print(snapshot.data);
                      var data = snapshot.data;
                      print(snapshot.data);
                      print("here..!");
                      RecordList rec = new RecordList.fromJson(data);
                      Provider.of<AppState>(context, listen: true).setOrderList(rec);
                      return  Body(list:rec);
                      }
                    }
            }
          },
        ),
          ),
        ],
      ),
    );
  }
}



class Body extends StatelessWidget {
  final RecordList list;
  const Body({Key key, this.list}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
             itemCount: list.toMap().length,
             itemBuilder: (context, index) {
    return Column(
      children: <Widget>[
        DeliveryInfoCard(record:list.toMap()[index]),
        Padding(padding: EdgeInsets.only(bottom:10)),
      ],
    );
  },
   ),
    );
  }
  
}

class  DeliveryInfoCard extends StatefulWidget {
    final Record record;
    const DeliveryInfoCard({Key key, this.record}) : super(key: key);
  @override
  _DeliveryInfoCard createState() => _DeliveryInfoCard();
}

class _DeliveryInfoCard extends State<DeliveryInfoCard>{

     Future<String>  progress() async{
        final response = await http.get('http://192.168.137.1/records/trackRecord.php?user_id=');
        return response.body;
     }
  @override
  Widget build(BuildContext context) {
  
  Future<String> prog =  progress();
    String progres = "";
    prog.then((val){
        setState((){
            progres = val;
            print("dd: "+ val);
        });
    });
    return Container(
      padding: EdgeInsets.all(7),
      height: 100,
      width: 500,
      decoration: BoxDecoration(
        color:Colors.cyan,
        borderRadius:BorderRadius.circular(5),
      ),
      child: Center(
        child: Column(
              children: <Widget>[
              Expanded(
                  child: Row(
                  children: <Widget>[
                    Expanded(flex:10,child: Text(widget.record.reciever)),
                    Expanded(child: Icon(Icons.info)),
                  ],
                ),
              ),
              Expanded(
                              child: Row(
                  children: <Widget>[
                    Expanded(child: Text(widget.record.destination.name)),
                  ],
                ),
              ),
              Expanded(
                              child: Row(
                  children: <Widget>[
                    Expanded(child: Text(widget.record.date)),
                    Expanded(child: Text(widget.record.time)),
                    Expanded(child: Text(progres)),
                  ],
                ),
              ),
              ],
        ),
      ),
    );
  }
  
}