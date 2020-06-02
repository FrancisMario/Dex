import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Address extends StatefulWidget {

  _Address createState()=>_Address();
}

class _Address extends State<Address> {

 
  Future<dynamic> getData(BuildContext context) async{    
  String url = Provider.of<AppState>(context, listen: false).serverUrl;
  
// Optionally the request above could also be done as
  var response = await http.get(
    "$url/market/entitylist.php"

  ).timeout(Duration(seconds: 10),onTimeout: (){
      // showError("NetWork Error, Please Try Again");
      print("timeout reached");
    }).catchError((onError){
      print("onError");
      print(onError);
    });

     switch (response.statusCode) {
          case 200:
            print("200");
            print(response.body);
            var data;
                try{
                data = json.decode(response.body);
                } catch(e){
                  return null;
                }
            return data;
          break;
          case 403:
            print("403");
            print(response);
          break;
          default:
            print("Error");
            print(response.statusCode);
          break;
        }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<dynamic>(
          ///If future is null then API will not be called as soon as the screen
          ///loads. This can be used to make this Future Builder dependent
          ///on a button click.
          // future: getData(context),
          future: Future.delayed(Duration(seconds: 5)),
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
                  print("Error: ${snapshot.data}");
                  return Text("Sorry there was an error");
                }

                // if the server sents a malformed data
                // if(snapshot.data == null){
                //   print("snapshot has error");
                //   print("malformed data: ${snapshot.data}");
                //   return Text("Server sent a malformed response");
                // }
                return  Container(
                    child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers:<Widget>[
                    SliverAppBar(
                        title:Text("Hello World"),
                        expandedHeight:200.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text("Title"),
                          background: Image.network("" //TODO
                          ,fit: BoxFit.cover,),
                          ),
                      ),

           new SliverList(
             key: widget.key,
             delegate: SliverChildListDelegate(_builder([
               {"details":"Very Good","name":"Book"},
               {"details":"Very Good","name":"Book"},
               {"details":"Very Good","name":"Book"},
               {"details":"Very Good","name":"Book"},
               {"details":"Very Good","name":"Book"}]))),
         ],
       ),
    );
            }
          },
        ),
       ),
      );
 
 
  }



  List _builder(dynamic data){
    List<Widget> items  = List();
    var deviceWidth = MediaQuery.of(context).size.width;

    items.add(
      Row(
        children: <Widget>[
          Expanded(
            child: 
             IconButton(
                 color:Colors.green[300],
                 icon: Icon(Icons.cancel), 
                 onPressed: null)),
          Expanded(
            child: 
             IconButton(
                 color:Colors.green[300], 
                 icon: Icon(Icons.add), 
                 onPressed: null))
        ],
      ),
    );


    for (var item in data) {
        items.add(
            GestureDetector(
              onTap: () {
                 Navigator.of(context).pop(); //Going back to the new order start page
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: Material(
                    child: Container(
                        color: Colors.amber,
                        child: Row(
                          children: <Widget>[
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(item['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 1.5,),
                                      Text(item['details'],style: TextStyle(),overflow: TextOverflow.clip,),
                                      SizedBox(height: 1.5,),
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.star,color: Colors.yellow,),
                                          Icon(Icons.star,color: Colors.yellow),
                                          Icon(Icons.star, color: Colors.yellow),
                                          Icon(Icons.star_half, color: Colors.yellow)
                                        ],
                                      ),
                                    ],
                                ),
                                  ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    IconButton(icon: Icon(Icons.ac_unit), onPressed: null),
                                    IconButton(icon: Icon(Icons.ac_unit), onPressed: null)
                                  ],
                                ),
                              ),
                         ],
                        ),
                    ),
                  
                ),
              ),
            ),
       );    
    }
    return items;
  }

  //   _getCurrentLocation() {
  //   final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  //   geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

}