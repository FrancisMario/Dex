import 'dart:convert';
import 'dart:math';

import 'package:dex/checkOut.dart';
import 'package:dex/checkOutAddress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:dex/appState.dart';
import 'package:dex/product.dart';

class DetailedEntityView extends StatefulWidget {
  final String ent_id;
  final String ent_des;
  final String ent_name;
  final String ent_img;

  DetailedEntityView({
    Key key,
    this.ent_id,
    this.ent_des,
    this.ent_name,
    this.ent_img,
  }) : super(key: key);
  List<Icon> logo = [Icon(Icons.add)];
  @override
  _DetailedEntityViewState createState() => _DetailedEntityViewState();
}

class _DetailedEntityViewState extends State<DetailedEntityView> {
  Future getData0;
  List productIds = [];
  @override
  void initState() {
    super.initState();
    getData0 = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        ///If future is null then API will not be called as soon as the screen
        ///loads. This can be used to make this Future Builder dependent
        ///on a button click.
        /**  Dear future developer of this code...
            *   this can better.
            *   It's your problem now. Deal with it. 
           */
        future: getData0,
        // future: Future.delayed(Duration(seconds: 4)), // Dear future developer of this code... this code can better. It's your problem now. Deal with it.
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
                return Container(
                  child: Text("Snapshot has error"),
                );
              }
              print(' snapshot.data ---------------------------------- ');
              print(snapshot.data);
              print(' snapshot.data ---------------------------------- ');
              if (snapshot.data == 404) {
                return Material(child: Text("404 Error"));
              }
              return _body(snapshot.data);
          }
        },
      ),
    );
  }

// Body
  Widget _body(List data) {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;

    if (data != null) {
      return Container(
        child: Scaffold(
          floatingActionButton: GestureDetector(
            onTap: (() {
              if (productIds.isEmpty) {
                showMessage("Cart is Empty");
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CheckOutAddress(
                    title: "Select An Address",
                    parent: "market",
                    data: {
                      "ent_id": widget.ent_id,
                      "ent_name": widget.ent_name,
                      "ent_img": widget.ent_img,
                      "products": productIds,
                    },
                  );
                }));
              }
            }),
            child: Container(
              // margin: EdgeInsets.only(right:10),
              width: 90,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Colors.white,
                      onPressed: () {}),
                  Text(
                    " ${productIds.length.toString()}",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Image.network(url + widget.ent_img,
                        key: widget.key, 
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                        ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        // IconButton(icon: Icon(Icons.shopping_basket,color: Colors.pink,semanticLabel:"ds"),iconSize: 30.0, onPressed: () {  },),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.ent_name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star_half, color: Colors.yellow)
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.ent_des,
                      style: TextStyle(fontSize: 15),
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Divider(
                        thickness: 1.5,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Products",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    // Text("CREATE TABLE `market_tables`.`#entity_ID#` ( `table_id` INT NOT NULL AUTO_INCREMENT , `entity_id` VARCHAR(10) NOT NULL , `entity_name` VARCHAR(20) NOT NULL , `entity_description` TEXT NOT NULL , `entity_image` VARCHAR(100) NOT NULL, `visible` VARCHAR(20) NULL , PRIMARY KEY (`table_id`)) ENGINE = InnoDB",overflow: TextOverflow.clip,),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    physics: BouncingScrollPhysics(),
                    children: List.generate(
                      data.length,
                      (index) {
                        widget.logo.add(Icon(Icons.add));
                        return Container(
                          child: Column(
                              children: <Widget>[_builder(data[index], index)]),
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sorry, there was an error",
                    style: TextStyle(fontSize: 16),
                  ),
                  FlatButton(
                    color: Colors.white,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ]),
          ),
        ),
      );
    }
  }

  // Builder
  Widget _builder(dynamic data, int index) {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                // height: 175.0,
                width: 175.0,
                child: Image.network(
                  url + data['image_0'],
                  key: widget.key,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  showDetails(data);
                },
                child: Container(
                  // height: 175.0,
                  width: 175.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black87.withOpacity(0.3),
                      Colors.black54.withOpacity(0.3),
                      Colors.black38.withOpacity(0.3),
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                  ),
                ),
              ),
              Positioned(
                bottom: 60.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      data['product_name'],
                      style: TextStyle(
                          //resturant name
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2),
                    ),
                    Text(
                      data['price'].toString(),
                      style: TextStyle(
                          // price
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 48,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                        icon: widget.logo[index],
                        color: Colors.white,
                        onPressed: () {
                          // Provider.of<AppState>(context, listen: false)
                          //     .cartProducts
                          //     .add(Product.fromJson(data));

                          if (!this.productIds.contains(data["product_id"])) {
                            setState(() {
                              widget.logo[index] = Icon(Icons.remove);
                            });

                            Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                this.productIds.add(data["product_id"]);
                                print('added ' + data["product_id"]);
                              });
                            });
                          } else {
                            setState(() {
                              widget.logo[index] = Icon(Icons.add);
                              print('removed ' + data["product_id"]);
                            });

                            Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                this.productIds.remove(data["product_id"]);
                              });
                            });
                          }
                        }),
                  )),
            ],
          )),
    );
  }

  showDetails(Map<String, dynamic> data) {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(data['product_name']),
            content: Container(
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Text(
                      "Price ${data['price'].toString()}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ]),
                  Row(
                    // description
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        data['product_description'],
                        overflow: TextOverflow.clip,
                      )),
                    ],
                  ),
                  Container(
                    height: 100,
                    width: 200,
                    child: Image.network(
                      url + data['image_0'],
                      key: widget.key,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    width: 200,
                    child: Image.network(
                      url + data['image_1'],
                      key: widget.key,
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: 200,
                    child: Image.network(
                      url + data['image_2'],
                      key: widget.key,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
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
  
  Future getData() async {
    String url = Provider.of<AppState>(context, listen: false).serverUrl;

// Optionally the request above could also be done as
    var response = await http.post("$url/getAllProductsFromEntity.php", body: {
      "entity_id": widget.ent_id
    }).timeout(Duration(seconds: 10), onTimeout: () {
      print("timeout reached");
    }).catchError((onError) {
      print("onError");
      print(onError);
    });

    print(response.request);

    print("entity id: ${widget.ent_id}");
    print("url : ${url}");
    print("entity id: ${widget.ent_id}");

    if (response != null) {
      switch (response.statusCode) {
        case 200:
          print("200");
          print(response.body);
          print("200");
          print(response.body);
          var data;
          try {
            data = json.decode(
                response.body.toString()); // parsing the server response
          } catch (e) {
            print("json parsing problem");
            return null;
          }
          print("everything success");
          return data;
          break;
        default:
          print("Error");
          print(response.statusCode);
          break;
      }
    } else {
      print("response returned null");
      print(response);
      print("response returned null");
      return 404;
    }
  }

}
