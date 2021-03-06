import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/entityList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CategoryView extends StatefulWidget {
  final String title;
  CategoryView({Key key, this.title}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();



}

class _CategoryViewState extends State<CategoryView> {

Future<dynamic> getData(BuildContext context) async{    
  String url = Provider.of<AppState>(context, listen: false).serverUrl;

// Optionally the request above could also be done as
  var response = await http.post(
    "$url/getAllVisibleCategories.php"
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
          default:
            print("Error");
            print(response.statusCode);
          break;
        }
  }else {
    print("response WAS NULL");
    print(response);
  }
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
        child: FutureBuilder(
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
                // if the response is 404
                if(snapshot.data.toString().trim() == "404"){
                  return Container(
                    child: Text("No categories added yet.!"),
                  );
                } else {


                print("snapshot data: ${snapshot.data}");
                var data1;
                try{
                data1 = json.decode(snapshot.data);
                } catch(e){
                  return Text("Error parsing json");
                }             
                print(data1[0]);
                print(data1[0]['category_name']);
                return  _body(data1);
            }
                }
          },
        ),
      ),
    );
  }

  Widget _body(List data){
  String url = Provider.of<AppState>(context, listen: false).serverUrl;
                print(data[0]['category_name']);
                print(data[0]['category_name']);
                print(data[0]['category_name']);
    return 
    Scaffold(
         appBar:AppBar(title:Text("Market Place")),
         body: 
         Container(
           margin: EdgeInsets.symmetric(horizontal:5,vertical: 10),
           width: MediaQuery.of(context).size.width - 10,
            child: GridView.count(crossAxisCount: 2, crossAxisSpacing: 1.2, mainAxisSpacing: 1.2,
            physics: BouncingScrollPhysics(),
            children: List.generate(
              data.length, (index) => 
                GestureDetector(
                  onTap: (){
                    Provider.of<AppState>(context, listen: false).session.addAll({
                      "category_id":data[index]["category_id"],
                      "category_img":data[index]["category_img"],
                      "category_name":data[index]["category_name"]
                      });
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                           return DetailedCategoryView(key: widget.key,id:data[index]["category_id"],img:data[index]["category_img"],name:data[index]["category_name"]); //Going back to the new order start page
                    }));
                   },
                  child: Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children:<Widget>[
                        Expanded( 
                          child: 
                          Image.network( 
                          url+"/"+data[index]["category_img"],
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
                            Text(data[index]['category_name'],style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2
                            ),),
                            // Text(url+data[index]['image']),
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