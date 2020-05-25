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

  showMessage(String title, String err){
     showDialog(
       builder: (BuildContext context){
        return AlertDialog(
            title: Text(title),
            content: Text(err),
            actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: (){
                  Navigator.of(context).pop();
              },
          )
          ],
        );
      }  
  );
  }

      getList(BuildContext context) async{
      String user_id = Provider.of<AppState>(context, listen: true).cred.user_id;
       final response = await http.post('http://34.67.233.153:3000/api/fetchRecord',
                headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
                body: jsonEncode(<String, String>{
                'user_id': user_id,
                }),)
        .timeout(
          Duration(seconds:10),
          onTimeout: (){
           print("143423");
             showMessage("Error","Network Error, Check connection and try Again.");
        });
        try {
        var res = jsonDecode(response.body) ;
        return res; 
        } catch(e){
             showMessage("Error","Network Error, Check connection and try Again.");
            return null;
        }
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
                      try{
                      RecordList rec = new RecordList.fromJson(data);
                      Provider.of<AppState>(context, listen: true).setOrderList(rec);
                      return  Body(list:rec);
                      }catch(e){
                           showMessage("Error",e.toString());
                       }
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
/**
 *  final String time;
  final String date;
  final String pickup;
  final String packageType;
  //  Address destination;
  final String reciever;
 */
  showDetails(){
     showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          title: Text(widget.record.name),
          content: Container(
            margin: EdgeInsets.all(5),
            child:Column(children: <Widget>[
              Row(
                children:<Widget>[ 
                Expanded(child: Text(widget.record.contact),),
                Expanded(child: Text(widget.record.date),),
                ]
              ),
              Row(
                children:<Widget>[ 
                Expanded(child: Text(widget.record.contact),),
                Expanded(child: Text(widget.record.time),),
                ]
              ),
              Row(
                children:<Widget>[ 
                Expanded(child: Text("Address"),),
                ]
              ),
              Row(
                children:<Widget>[ 
                Expanded(child: Divider(),),
                Expanded(child: null,),
                Expanded(child: null,)
                ]
              ),
              Row(
                children:<Widget>[ 
                Expanded(child: Text(widget.record.address),),
                ]
              ),
            ],)
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: (){
                  Navigator.of(context).pop();
              },
          )
          ],
        );
    }
    
  );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      height: 100,
      width: 500,
      decoration: BoxDecoration(
        color:Colors.black26,
        borderRadius:BorderRadius.circular(5),
      ),
      child: Center(
        child: Column(
              children: <Widget>[
              Expanded(
                  child: Row(
                  children: <Widget>[
                    Expanded(flex:10,child: Text(widget.record.name)),
                    Expanded(child: GestureDetector(child: Icon(Icons.info),onTap: (){
                      // TODO infor dialog
                      showDetails();
                      },
                     ),
                    ),
                  ],
                ),
              ),
              Expanded(
                              child: Row(
                  children: <Widget>[
                    Expanded(child: Text(widget.record.address)),
                  ],
                ),
              ),
              Expanded(
                              child: Row(
                  children: <Widget>[
                    Expanded(child: Text(widget.record.date)),
                    Expanded(child: Text(widget.record.time)),
                  ],
                ),
              ),
              ],
        ),
      ),
    );
  }
  
}
