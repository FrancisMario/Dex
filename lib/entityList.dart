import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/detailedEntityView.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class DetailedCategoryView extends StatefulWidget {
  final String id;
  final String img;
  DetailedCategoryView({Key key, this.id, this.img}) :  assert(id != null), super(key: key);

  @override
  DetailedStateCategoryView createState() => DetailedStateCategoryView();

  
  var data = [
    
    {"name":"McCesers","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner}
  ];
}

class DetailedStateCategoryView extends State<DetailedCategoryView> {

  Future<dynamic> getData(BuildContext context) async{    
  String url = Provider.of<AppState>(context, listen: false).serverUrl;
  
// Optionally the request above could also be done as
  var response = await http.get(
    "$url/market/entitylist.php?entity=${widget.id}"

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
          future: getData(context),
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
                if(snapshot.data == null){
                  print("snapshot has error");
                  print("malformed data: ${snapshot.data}");
                  return Text("Server sent a malformed response");
                }
                return  Container(
                    child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers:<Widget>[
                    SliverAppBar(
                        title:Text("Hello World"),
                        expandedHeight:220.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text("Title"),
                          background: Image.network(widget.img,fit: BoxFit.cover,),
                          ),
                      ),

           new SliverList(
             key: widget.key,
             delegate: SliverChildListDelegate(_builder(snapshot.data))),
         ],
       ),
    );
            }
          },
        ),
       ),
      );
 
 
  }


//  Widget sliver() {
//     Container(
//        child: CustomScrollView(
//          physics: BouncingScrollPhysics(),
//          slivers:<Widget>[
//            SliverAppBar(
//             title:Text("Hello World"),
//             expandedHeight:220.0,
//             floating: false,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               centerTitle: true,
//               title: Text("Title"),
//               background: Image.asset('assets/dish.png',fit: BoxFit.cover,),
//             ),
//            ),

//            new SliverList(
//              key: widget.key,
//              delegate: SliverChildListDelegate(_builder())),
//          ],
//        ),
//     );
//   } 



  List _builder(dynamic data){
    List<Widget> items  = List();
    var deviceWidth = MediaQuery.of(context).size.width;

    for (var item in data) {
        items.add(
            GestureDetector(
              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                           return DetailedEntityView(key: widget.key,id:item['entity_id']); //Going back to the new order start page
                 }));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: Material(
                    child: Container(
                        color: Colors.amber,
                        child: Row(
                          children: <Widget>[
                              Image(
                                width: 100,
                                height: 100,
                                image: AssetImage('assets/food.JPG'), // TODO this should be a network fetch of the valid entity img
                                fit: BoxFit.cover,
                                ),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
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
                              )
                         ],
                        ),
                    ),
                  
                  //   child: ListTile(
                  //   leading: Icon(Icons.add),
                  //   trailing: Icon(Icons.view_headline),
                  //   title: Text(item['name']),
                  
                  // ),
                ),
              ),
            ),
       );    
    }
    return items;
  }
}