import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/entityList.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CategoryView extends StatefulWidget {
  final String title;
  CategoryView({Key key, this.title}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();

  var data = [
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner}
  ];




}

class _CategoryViewState extends State<CategoryView> {

Future<dynamic> getData(BuildContext context) async{    
  String url = Provider.of<AppState>(context, listen: false).serverUrl;
  Dio dio = new Dio();
  dio.options.baseUrl = url;

// Optionally the request above could also be done as
  var response = await http.get(
    "$url/market/marketList.php"
  ).timeout(Duration(seconds: 10),onTimeout: (){
      // showError("NetWork Error, Please Try Again");
      print("timeout reached");
    }).catchError((onError){
      print("onError");
      print(onError);
    });

  if(response.statusCode != null){
     switch (response.statusCode) {
          case 200:
            print("200");
            print(response.body);
            return response.body;
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
  }else {
    print(response);
  }
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
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
                return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));

              case ConnectionState.done:
                ///task is complete with an error (eg. When you
                ///are offline)
                if (snapshot.hasError){
                  print("snapshot has error");
                  print(snapshot.error); 
                  return Text("Error");
                }
                print("snapshot data: ${snapshot.data}");
                var data;
                try{
                data = json.decode(snapshot.data);
                } catch(e){
                  return Text("Error parsing json");
                }             
                print(data);
                return  _body(data);
            }
          },
        ),
      ),
    );
  }

  Widget _body(List<dynamic> data){
    return 
    Scaffold(
         appBar:AppBar(title:Text("Market Place")),
         body: Container(
           margin: EdgeInsets.symmetric(horizontal:5,vertical: 10),
           width: MediaQuery.of(context).size.width - 10,
            child: GridView.count(crossAxisCount: 2, crossAxisSpacing: 1.2, mainAxisSpacing: 1.2,
            physics: BouncingScrollPhysics(),
            children: List.generate(
              data.length, (index) => 
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                           return DetailedCategoryView(key: widget.key,id:data[index]["id"],img:data[index]["image"]); //Going back to the new order start page
                    }));
                   },
                  child: Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children:<Widget>[
                        Expanded( 
                          child: 
                          Image.network( 
                          data[index]["image"],
                          fit: BoxFit.cover,
                          )
                          ),
                        Container(
                        decoration: BoxDecoration(
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
                      //  Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: <Widget>[
                      //       Text(data[index]["name"]),
                      //       Text(data[index]["id"]),
                      //     ],
                      //   ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(data[index]['name'],style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2
                            ),),
                        ],),
                      ),
                      ]
                    ),
                  ),
                ),
              )
            ),
         ),
       );
  }
}