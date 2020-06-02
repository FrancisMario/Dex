import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedEntityView extends StatefulWidget {
  final String id;
  DetailedEntityView({Key key, this.id}) : super(key: key);

  @override
  _DetailedEntityViewState createState() => _DetailedEntityViewState();

   
  var menu = [
    {"name":"Noodles","id":"1234","price":200,"picture":"assets/food.JPG"},
    {"name":"Noodles","id":"1234","price":200,"picture":"assets/food.JPG"},
    {"name":"Noodles","id":"1234","price":200,"picture":"assets/food.JPG"},
    {"name":"Noodles","id":"1234","price":200,"picture":"assets/food.JPG"},
    {"name":"Noodles","id":"1234","price":200,"picture":"assets/food.JPG"}
  ];
}

class _DetailedEntityViewState extends State<DetailedEntityView> {
  @override
  Widget build(BuildContext context) {


    return Center(
        child: FutureBuilder<Map>(
          ///If future is null then API will not be called as soon as the screen
          ///loads. This can be used to make this Future Builder dependent
          ///on a button click.
          future: getData(context), // Dear future developer of this code... this code can better. It's your problem now. Deal with it. 
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
                  return Container(
                    child:Text("Snapshot has error"),
                  );
                }
                  print("fsoef aseuofaspoe fpaseupfas fperh wraw9rcg aw rbaur9a wirawuoerh awc9erauiwer awr");
                  print(snapshot.data); 
                return  _body(snapshot.data);
            }
          },
        ),
      ); 
  }

// Body
  Widget _body(dynamic data){ 
    print("---------------------------------------------");
    print(data);
    print("---------------------------------------------");
    return Container(
       child: Scaffold(
         floatingActionButton: Container(
                          // margin: EdgeInsets.only(right:10),
                    width:48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: IconButton( 
                              icon: Icon(Icons.shopping_cart), 
                              color: Colors.white,
                              onPressed: () {
                                   print("dd");
                              }),
                      ),
          body: Column(
            children:<Widget>[
                Stack(
                  children: <Widget>[ 
                    Image(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        image: AssetImage('assets/food.JPG'), // TODO
                        fit: BoxFit.cover,
                        ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 20.0), 
                      child: Row(
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),iconSize: 30.0),
                            IconButton(icon: Icon(Icons.shopping_basket,color: Colors.pink,semanticLabel:"ds"),iconSize: 30.0,),
                           ],
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                        SizedBox(height: 5,),
                        Text("data['details']['name']",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.star,color: Colors.yellow,),
                            Icon(Icons.star,color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star_half, color: Colors.yellow)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text("data['details']['location']",style: TextStyle(fontSize:20),),
                        SizedBox(height: 10,),
                        SizedBox(height: 10,width: MediaQuery.of(context).size.width / 1.3, child: Divider(thickness: 1.5,),),
                        SizedBox(height: 3,),
                         Text("Menu",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                        // Text("CREATE TABLE `market_tables`.`#entity_ID#` ( `table_id` INT NOT NULL AUTO_INCREMENT , `entity_id` VARCHAR(10) NOT NULL , `entity_name` VARCHAR(20) NOT NULL , `entity_description` TEXT NOT NULL , `entity_image` VARCHAR(100) NOT NULL, `visible` VARCHAR(20) NULL , PRIMARY KEY (`table_id`)) ENGINE = InnoDB",overflow: TextOverflow.clip,),
                  ],
                ),
              ),
            
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                physics: BouncingScrollPhysics(),
                children:
                  List.generate(
                    4, 
                      (index) => Container(
                              child: Column(
                                  children:<Widget> [
                                      Text("$index"),
                                      Text(data),
                                      ]
                                )
                              ),
                    )
                ),
            ),
            ],
          ),
       ),
    );
  
  }



  // Builder
   Widget _builder(dynamic data){
         return  GestureDetector(
              onTap: () {
                 
              },
              child: 
              Container(
                margin: EdgeInsets.all(10),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: 175.0,
                      width: 175.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:AssetImage('assets/food.JPG'),
                          fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    GestureDetector(
                      onLongPress: (){
                        showDetails({"name":data['name'],"description":data['description']});
                      },
                        child: Container(
                        height: 175.0,
                        width: 175.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.black87.withOpacity(0.3),
                              Colors.black54.withOpacity(0.3),
                              Colors.black38.withOpacity(0.3),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60.0,
                      child: Column(
                        children: <Widget>[
                          Text(data['name'],style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2
                          ),),
                          Text(data['price'],style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2
                          ),),
                      ],),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child:  Container(
                          // margin: EdgeInsets.only(right:10),
                          width:48,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: IconButton(
                                  icon: Icon(Icons.add), 
                                  color: Colors.white,
                                  onPressed: () {
                                      print("dd");
                                  }),
                      )
                    ),
                    
                  ],
                )
              ),
            );
  }

 showDetails(Map<String,dynamic> data){
     showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          scrollable: true,
          title: Text("Details"),
          content:  Container(
            height: 150,
            child: Column(
                        children: <Widget>[
                          Expanded(
                            child:
                            Text(data['name']),
                          ),
                          Expanded(
                              child: Text(data['description'],
                              style: TextStyle(
                              ),overflow: TextOverflow.clip,),
                              ),
                  
                        ],
                      ),
          ) ,
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


Future getData(BuildContext context) async{    
  String url = Provider.of<AppState>(context, listen: false).serverUrl;
  
// Optionally the request above could also be done as
    var response = await http.get(
      "$url/market/entityProducts.php?entity_id=${widget.id}"
    ).timeout(Duration(seconds: 10),onTimeout: (){
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
                try {
                    data = json.decode(response.body.toString()); // parsing the server response 
                   } 
                catch(e) {
                  print("json parsing problem");
                  return null;
                }
                  print("------------------------------------------------------");
                  print(data);
                  print("------------------------------------------------------");
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
}