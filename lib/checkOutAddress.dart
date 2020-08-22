import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/checkOut.dart';
import 'package:dex/dataStructures.dart';
import 'package:dex/normalAddress.dart';
import 'package:dex/smartAddress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class CheckOutAddress extends StatefulWidget {
  final String parent;
  final String title;
  final Map data;

  CheckOutAddress({Key key, this.parent = 'null', this.title = "My Addresses", this.data})
      : super(key: key);
  List<Widget> items = List();
  _Address createState() => _Address();
}

class _Address extends State<CheckOutAddress> {
 
  deleteAddress(String id, BuildContext context) async {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;
    String user_id = Provider.of<AppState>(context, listen: false).cred.user_id;

// Optionally the request above could also be done as
    var response = await http.post(
      "$url/market/deleteAddress.php",
      body: {'user_id': user_id, 'table_id': id},
    ).timeout(Duration(seconds: 10), onTimeout: () {
      // showError("NetWork Error, Please Try Again");
      print("timeout reached");
      showMessage("Error.. check connection");
    }).catchError((onError) {
      print("onError");
      print(onError);
      showMessage("Error.. check connection");
    });

    switch (response.statusCode) {
      case 200:
        print("200");
        showMessage("Address deleted");
        return true;
        break;
      default:
        // if server error occurs. 404, 500 etc.
        print("Error");
        print(response.statusCode);
        showMessage("ERROR. Address was Not deleted");
        return false;
        break;
    }
  }

    isCharacter(String a){
        List b = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
        List c = ['1','2','3','4','5','6','7','8','9','0','-','=','"',"'",'<','>','/','\\',' ',':',';','!','@','#','\$','%','^','&','*','(',')','_','+','.',',','[',']','{','}'];

        if (b.contains(a.toLowerCase().trim()) || c.contains(a)) {
            return true; 
        }

        return false;
  }

  prepString(String a){
      
      var b = a.split('');
      var c = '';
      for (var item in b) {
        if (isCharacter(item)) {
          c += item;
          print("++++++$item");
        } else {
          c += '\\n';
          print("-----$item");
        }
      }
      return c;
  }



  Future<dynamic> getData() async {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;
    String user_id = Provider.of<AppState>(context, listen: false).cred.user_id;

// Optionally the request above could also be done as
    var response = await http.post(
      "$url/market/getAddress.php",
      body: {"user_id": user_id},
    ).timeout(Duration(seconds: 10), onTimeout: () {
      // showError("NetWork Error, Please Try Again");
      print("timeout reached");
    }).catchError((onError) {
      print("onError");
      print(onError);
    });

    switch (response.statusCode) {
      case 200:
        print("200");
        print(response.body);
        var data;
        if (response.body != "404") {
          try {
            data = prepString(response.body);
            data = json.decode(data);
          } catch (e) {
            // if server sends malformed data.
            print(e);
            return null;
          }
          return data;
        }
        return response.body;
        break;
      default:
        print("Error");
        print(response.statusCode);
        return null; // if server error occurs. 404, 500 etc.
        break;
    }
  }

   showMessage(String massage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text(massage),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }         

  Future getData0;

   @override
  void initState() {
    super.initState();
    getData0 = getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: FutureBuilder<dynamic>(
          ///If future is null then API will not be called as soon as the screen
          ///loads. This can be used to make this Future Builder dependent
          ///on a button click.
          // future: _dummyData,
          future: getData0,
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
                if (snapshot.hasError) {
                  print("snapshot has error");
                  print(snapshot.error);
                  print("Error: ${snapshot.data}");
                  return Text("Sorry there was an error");
                }

                // if the server sents a malformed json
                if (snapshot.data == null) {
                  print("snapshot has error");
                  print("malformed data: ${snapshot.data}");
                  return Text("Server sent a malformed response");
                }
                print('==========================================');
                print(snapshot.data);
                print('==========================================');
                var intermediate = null;
                if (snapshot.data == "404") {
                  intermediate = json.decode('[]'); // simulating an empty array.
                } else {
                  intermediate = snapshot.data;
                }
                widget.items.clear();
                widget.items.add(
                  Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 4,
                              child: FlatButton(
                                color: Colors.blueGrey,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                onPressed: () async{
                                var result = await Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context){return NormalAddress();}));

                                    if (!result == null) {
                                      try{
                                      var a = json.decode(result);
                                      widget.items.add(_addressCard(a));
                                      setState(() {
                                        
                                      });
                                      }
                                      catch(e){
                                        print(e);
                                      }
                                    }

                                  },
                                child:
                                Row(children: <Widget>[
                                 Text("",style: TextStyle(fontSize: 15.0,color: Colors.white),),
                                 Expanded(child: Text(" Normal Address",style: TextStyle(fontSize: 20.0,color: Colors.white),overflow: TextOverflow.ellipsis,)),

                                ],)
                              )),
                          Expanded(
                            flex: 1,
                            child: Text(""),
                          ),
                          Expanded(
                              flex: 4,
                              child: FlatButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                onPressed: () async{
                                  var result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return SmartAddress();}));
                                    
                                    if (!result == null) {
                                      try{
                                      var a = json.decode(result);
                                      setState(() {
                                      widget.items.add(_addressCard(a));
                                      });
                                      }
                                      catch(e){
                                        print(e);
                                      }
                                    }
                                },
                                child:
                                Row(children: <Widget>[
                                 Text("",style: TextStyle(fontSize: 15.0,color: Colors.white),),
                                 Text(" Smart Address",style: TextStyle(fontSize: 20.0,color: Colors.white),),

                                ],)
                              )
                              )
                        ],
                      ),
                    ),
                    Divider()
                  ]),
                );
                return Container(
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        // title:Text("Hello World"),
                        expandedHeight: 150.0,
                        floating: true,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(widget.title,style: TextStyle(
                            color: Colors.white
                            ),
                          ),
                          background: 
                          Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.asset(
                                "assets/mapHeader.png",
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      new SliverList(
                        key: widget.key,
                        delegate: SliverChildListDelegate(
                          _builder(intermediate),
                        ),
                      ),
                    ],
                  ),
                );

              // test conttroller

              // return smartAddress();
              // return normalAddress();
            }
          },
        ),
      ),
    );
  }

  Widget button(item) {
    if (widget.parent == "null") {
      Provider.of<AppState>(context, listen: false).cartAddress =
          Address.fromJson(item);
      return Expanded(
        child: Column(
          children: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Provider.of<AppState>(context, listen: false).cartAddress =
                    Address.fromJson(item);
              },
              child: Text(
                "Delete",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      );
    } else if (widget.parent == "market") {
      return Expanded(
        child: Column(
          children: <Widget>[
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Provider.of<AppState>(context, listen: false).cartAddress =
                    Address.fromJson(item);
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return CheckOut();}));

              },
              child: Text(
                "Select",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      );
    }
  }

 
  
  
  
  

  List _builder(dynamic data) {
    var deviceWidth = MediaQuery.of(context).size.width;

    for (var item in data) {
      widget.items.add(_addressCard(item));
    }

    // displaying the message that there are currently no address for the user

    if (widget.items.length == 1) {
      widget.items.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 100),
        child: Text(
            "There are currently no addresses associated with this acount"),
      ));
    }
    return widget.items;
  }

  _addressCard(dynamic item) {
    return GestureDetector(
      onTap: () {
        //  Navigator.of(context).pop(); //Going back to the new order start page
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
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          item['name'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 1.5,
                        ),
                        Text(
                          item['description'],
                          style: TextStyle(),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        // Row(
                        //   children: <Widget>[
                        //     Icon(Icons.star,color: Colors.yellow,),
                        //     Icon(Icons.star,color: Colors.yellow),
                        //     Icon(Icons.star, color: Colors.yellow),
                        //     Icon(Icons.star_half, color: Colors.yellow)
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                button(item)
              ],
            ),
          ),
        ),
      ),
    );
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
