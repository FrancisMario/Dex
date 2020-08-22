import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/dataStructures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class Tracking extends StatefulWidget {
  Tracking({Key key}) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {

  List<Text> records = [];

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

  Future getList(BuildContext context) async{
      String user_id = Provider.of<AppState>(context, listen: true).cred.user_id;
      String url = Provider.of<AppState>(context, listen: true).serverUrl;

       final response = await http.post('$url/market/getUserOrders.php',
        body: { 'user_id': user_id,'type':'delivered'})
        .timeout(
          Duration(seconds:10),
          onTimeout: (){
           print("timeout");
             showMessage("Error","Network Error, Check connection and try Again.");
        });
      print(response.body);

        if(response.body != "404"){
            try {    
              print("parsing");
                var res = jsonDecode(response.body) ;
              print(res);
              print("parsed");
                return res;
          } catch(e){
             showMessage("Error","Something went wrong"); 
            return "404";
           }
        } else {
             showMessage("Error","Something went wrong"); 
          return "404";
        }

      


  }

  @override
  void initState() {
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
    getList(context);
    return Container(
       child: FutureBuilder<dynamic>(
         future: getList(context),
         builder: (context, snapshot){
            switch (snapshot.connectionState) {

              ///when the future is null
              case ConnectionState.none:
                return Container(
                  height: 100,
                  width: 100,
                  child: Text(
                    'Press the button to fetch data',
                    textAlign: TextAlign.center,
                  ),
                );

              case ConnectionState.active:

              ///when data is being fetched
              case ConnectionState.waiting:
                return Container(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
                  ),
                );

              case ConnectionState.done:

                ///task is complete with an error (eg. When you
                ///are offline)
                if (snapshot.hasError) {
                  print("snapshot has error");
                  print(snapshot.error);
                  print("Error: ${snapshot.data}");
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 20),
                    child: Text("No Data collected yet ",style: TextStyle(fontSize:25),),
                  );
                }
              return Container(
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      // SliverAppBar(
                      //   // title:Text("Hello World"),
                      //   expandedHeight: 0.0,
                      //   floating: false,
                      //   pinned: false,
                      //   flexibleSpace: FlexibleSpaceBar(
                      //     centerTitle: true,
                      //     title: Text("Hello"),
                      //     background: Image.network(
                      //       "" //TODO
                      //       ,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      new SliverList(
                        key: widget.key,
                        delegate: SliverChildListDelegate(
                          List.generate(snapshot.data.length, (index){
                            return card(snapshot.data[index]);
                          })
                          // _builder(intermediate),
                        ),
                      ),
                    ],
                  ),
                );
            }
          }
         )
    );
  }

  Widget card(Map data){
   return  Padding(
     padding: const EdgeInsets.all(15.0),
     child: Container(
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Row(
                children: <Widget>[
                  Text("${data['name']}",style: TextStyle(
                    color: Colors.white,
                    fontSize:30,
                    fontWeight: FontWeight.w600   
                  ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Row(
                children: <Widget>[
                  Text("${data['delivery_time']}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:24,
                    fontWeight:FontWeight.w600
                  ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text("")),
                  Expanded(
                    child: Center(
                      child: Text("${data['status']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:26,
                        fontWeight: FontWeight.bold),)))
                ],
              ),
            ),
          ],
        ),
      ),
  ),
   );
  } 
}