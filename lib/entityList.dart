import 'dart:convert';

import 'package:dex/appState.dart';
import 'package:dex/detailedEntityView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'
as http;


class DetailedCategoryView extends StatefulWidget {
  final String id;
  final String img;
  final String name;
  DetailedCategoryView({
    Key key,
    this.name = "Resturants",
    this.id = "2d5151e8d45ba9b5452edb2a618e28a0",
    this.img = "uploads/category/e87bd8490058ff354e975b19c87de7d9.JPG"
  }): assert(id != null), super(key: key);

  @override
  DetailedStateCategoryView createState() => DetailedStateCategoryView();

}

class DetailedStateCategoryView extends State < DetailedCategoryView > {

  Future < dynamic > getData(BuildContext context) async {
    String url = Provider.of < AppState > (context, listen: false).serverUrl;

    // Optionally the request above could also be done as
    var response = await http.post(
      "$url/market/getAllEntityFromCategory.php",
      body: {
        "category_id": widget.id
      }
    ).timeout(Duration(seconds: 10), onTimeout: () {
      // showError("NetWork Error, Please Try Again");
      print("timeout reached");
    }).catchError((onError) {
      print("onError");
      print(onError);
    });

    switch (response.statusCode) {
      case 200:
        print(response.body);
        if (response.body == "404") {
          return null;
        }
        var data;
        try {
          data = json.decode(response.body);
        } catch (e) {
          return false;
        }
        return data;
        break;
      default:
        print("Error");
        print(response.statusCode);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String url = Provider.of < AppState > (context, listen: false).serverUrl;
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          ///If future is null then API will not be called as soon as the screen
          ///loads. This can be used to make this Future Builder dependent
          ///on a button click.
          future: getData(context), // live purpose
          // future: Future.delayed(Duration(seconds: 3)), //testing purposes
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
                  valueColor: AlwaysStoppedAnimation < Color > (Colors.blue));

              case ConnectionState.done:
                ///task is complete with an error (eg. When you
                ///are offline)
                if (snapshot.hasError) {
                  print("snapshot has error");
                  print(snapshot.error);
                  print("Error: ${snapshot.data}");
                  return Text("Sorry there was an error");
                }

                // if the server has no data
                if (snapshot.data == null) {
                  print("no data in database");
                  // return Text("no data in database");
                // if the server has error
                } else if (snapshot.data == false) {
                  print("snapshot has error");
                  print("malformed data: ${snapshot.data}");
                  return Text("Server sent a malformed response");
                }
                return Container(
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: < Widget > [
                      SliverAppBar(
                        // title:Text("Hello World"),
                        expandedHeight: 220.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(widget.name),
                          background: Image.network(url + '/market/' + widget.img, key: widget.key, fit: BoxFit.cover, ),
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



  List _builder(data) {
    String url = Provider.of < AppState > (context, listen: false).serverUrl;
    List < Widget > items = List();
    items.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal:10),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.center,
            children:<Widget>[
              SizedBox(height: 10,),
              Center(child: Text("just some cool things about the vendor just some cool things about the vendor things about the vendor things about the vendor .",style: TextStyle(
                fontSize: 20
              ),overflow: TextOverflow.clip),),
              SizedBox(height: 5,),
              Divider(),
            ],
          ),
        ),
      );
    if(data == null){
      items.add(
        Container(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.center,
            children:<Widget>[
              SizedBox(height: 10,),
              Center(child: Text("this category doesn't have any vendors yet."))
            ],
          ),
        ),
      );
    } else 
    {
    var deviceWidth = MediaQuery.of(context).size.width;

    for (var item in data) {
      items.add(
        GestureDetector(
          onTap: () {
            print(item['entity_id']);
            print(item['entity_description']);
            print(item['entity_name']);
            print(item['image_0']);
            print(item['entity_description']);
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return DetailedEntityView(ent_id: item['entity_id'], ent_des:item['entity_description'], ent_name:item['entity_name'], ent_img:item['image_0']); //Going back to the new order start page
            }));
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Material(
              child: Container(
                color: Colors.amber,
                child: Row(
                  children: < Widget > [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.network(url + '/market/' + item['image_0'], key: widget.key, fit: BoxFit.cover, ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: < Widget > [
                              Text(item['entity_name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
                              SizedBox(height: 1.5, ),
                              Text(item['entity_description'], style: TextStyle(), overflow: TextOverflow.clip, ),
                              SizedBox(height: 1.5, ),
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
  }
    return items;
  }
}