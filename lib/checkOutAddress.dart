import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/dataStructures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CheckOutAddress extends StatefulWidget {
  final String parent;
  final String title;

  CheckOutAddress({Key key, this.parent = 'null', this.title = "Addresses"})
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
        break;
      default:
        // if server error occurs. 404, 500 etc.
        print("Error");
        print(response.statusCode);
        showMessage("ERROR. Address was Not deleted");
        break;
    }
  }

  Future<dynamic> getData(BuildContext context) async {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;
    String user_id = Provider.of<AppState>(context, listen: false).cred.user_id;

// Optionally the request above could also be done as
    var response = await http.post(
      "$url/market/getAddress.php",
      body: {user_id: user_id},
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
            data = json.decode(response.body);
          } catch (e) {
            // if server sends malformed data.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<dynamic>(
          ///If future is null then API will not be called as soon as the screen
          ///loads. This can be used to make this Future Builder dependent
          ///on a button click.
          // future: _dummyData,
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
                  intermediate = json.decode('[]');
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
                                color: Colors.blue,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                onPressed: () {
                                  /*...*/
                                },
                                child: Text(
                                  "Back",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              )),
                          Expanded(
                            flex: 1,
                            child: Text(""),
                          ),
                          Expanded(
                              flex: 4,
                              child: FlatButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      child: Container(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              // Redirect to the page
                                              print("object");
                                              normalAddress();
                                            },
                                            child: Container(
                                              color: Colors.white,
                                              height: 150,
                                              width: 150,
                                              child: Center(
                                                child: 
                                                    Text("Normal", style: TextStyle(fontSize: 20,color: Colors.black),
                                                    
                                                ),
                                              ),
                                            ),
                                          ),
                                            SizedBox(width: 10,),
                                           GestureDetector(
                                            onTap: () {
                                              // Redirect to the page
                                            print("object1");
                                            smartAddress();
                                            },
                                            child: Container(
                                              color: Colors.white,
                                              height: 150,
                                              width: 150,
                                              child: Center(
                                                child: Text( "Smart", style: TextStyle( fontSize: 20,color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )));
                                },
                                child: Text(
                                  "Add Address",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ))
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
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(widget.title),
                          background: Image.network(
                            "" //TODO
                            ,
                            fit: BoxFit.cover,
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
                //TODO Navigate to check out.
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

  Widget smartAddress() {
    // phone textbox box controller
    final _addressNameController = TextEditingController();
    final _addressDescriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Smart Address")),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 10,
              child: Text(
                "Smart  Addresses are very acurate, they enable us to quicky locate you. However, you have to be physicaly at the address to add it.",
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 10),
            new TextFormField(
              maxLength: 10,
              controller: _addressNameController,
              decoration: new InputDecoration(
                labelText: "Give this address a name.",
                fillColor: Color.fromRGBO(62, 62, 62, 1),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "phone cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.text,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),
            new TextFormField(
              maxLines: 3,
              controller: _addressDescriptionController,
              decoration: new InputDecoration(
                labelText: "Add some descriptions will ya?",
                fillColor: Color.fromRGBO(62, 62, 62, 1),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "phone cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.multiline,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () async {
                if (_addressNameController.value.text != "" &&
                    _addressDescriptionController.value.text != "") {
                  _saveSmartAddress(_addressNameController.value.text,
                      _addressDescriptionController.value.text, "mm");
                } else {
                  showMessage("You must fill all fields");
                }
              },
              child: Container(
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    "SAVE",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget normalAddress() {
    // phone textbox box controller
    final _addressNameController = TextEditingController();
    final _addressDescriptionController = TextEditingController();
    final _addressLocationController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Normal Address")),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 10,
              child: Text(
                "Normal Addresses are alot less acurate than smart address. They require a detailed description of the location.",
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 10),
            new TextFormField(
              maxLength: 10,
              controller: _addressNameController,
              decoration: new InputDecoration(
                labelText: "Give this address a name.",
                fillColor: Color.fromRGBO(62, 62, 62, 1),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "phone cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.text,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),
            new TextFormField(
              maxLines: 3,
              controller: _addressDescriptionController,
              decoration: new InputDecoration(
                labelText: "Add some descriptions will ya?",
                fillColor: Color.fromRGBO(62, 62, 62, 1),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "phone cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.multiline,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),
            new TextFormField(
              maxLines: 7,
              controller: _addressLocationController,
              decoration: new InputDecoration(
                // labelText: "Describe the Location.",
                hintText: "eg. West-Coast-Region  Serekunda  Bamboo",
                hintStyle: TextStyle(wordSpacing: 1000, fontSize: 20),
                fillColor: Color.fromRGBO(62, 62, 62, 1),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "this camnnot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.multiline,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () async {
                if (_addressNameController.value.text != "" &&
                    _addressDescriptionController.value.text != "" &&
                    _addressLocationController.value.text != "") {
                  _saveNormalAddress(
                      _addressNameController.value.text,
                      _addressDescriptionController.value.text,
                      _addressLocationController.value.text);
                } else {
                  showMessage("You must fill all fields");
                }
              },
              child: Container(
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    "SAVE",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveNormalAddress(String name, String description, String location) async {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;
    String user_id = Provider.of<AppState>(context, listen: false).cred.user_id;

    var response = await http.post("$url/market/addAddress.php", body: {
      "user_id": user_id,
      "name": name,
      "description": description,
      "coordinates": location,
      "type": "normal"
    }).timeout(Duration(seconds: 10), onTimeout: () {
      print("timeout reached");
    }).catchError((onError) {
      print("onError");
      print(onError);
    });

    switch (response.statusCode) {
      case 200:
        print("200");
        print(response.body);
        await showMessage("Address was Successfully Added.");
        widget.items.add(_addressCard({
          "user_id": user_id,
          "name": name,
          "description": description,
          "coordinates": location,
          "type": "normal"
        }));
        break;
      default:
        await showMessage("Sorry, there was an error.");
        print("Error");
        print(response.statusCode);
        break;
    }
    Navigator.of(context).pop();
  }

  _saveSmartAddress(String name, String description, String location) async {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;
    String user_id = Provider.of<AppState>(context, listen: false).cred.user_id;

    var response = await http.post("$url/market/addAddress.php", body: {
      "user_id": user_id,
      "name": name,
      "description": description,
      "type": "smart",
      "coordinates": "{'lat':'','long':''}"
    }).timeout(Duration(seconds: 10), onTimeout: () {
      print("timeout reached");
    }).catchError((onError) {
      print("onError");
      print(onError);
    });

    switch (response.statusCode) {
      case 200:
        print("200");
        print(response.body);
        widget.items.add(_addressCard({
          "user_id": user_id,
          "name": name,
          "description": description,
          "coordinates": "{'lat':'','long':''}",
          "type": "smart"
        }));
        await showMessage("Address was Successfully Added.");
        break;
      default:
        await showMessage("Sorry, there was an error.");
        print("Error");
        print(response.statusCode);
        break;
    }
    Navigator.of(context).pop();
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
