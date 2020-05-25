import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';

class DetailedCategoryView extends StatefulWidget {
  DetailedCategoryView({Key key}) : super(key: key);

  @override
  DetailedStateCategoryView createState() => DetailedStateCategoryView();

  
  var data = [
    {"details":"a list of the best resturants serving your favorite foods.","entity_id":"1234","image":"entity_image"},
    {"name":"McCesers","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner},
    {"name":"Pharmaticals","id":"1234","icon":Icons.scanner}
  ];
}

class DetailedStateCategoryView extends State<DetailedCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              background: Image.asset('assets/dish.png',fit: BoxFit.cover,),
            ),
           ),

           new SliverList(
             key: widget.key,
             delegate: SliverChildListDelegate(_builder())),
         ],
       ),
    );
  }

  List _builder(){
    List<Widget> items  = List();
    var deviceWidth = MediaQuery.of(context).size.width;

    for (var item in widget.data) {
        items.add(
            GestureDetector(
              onTap: () {
                 
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
                                image: AssetImage('assets/food.JPG'),
                                fit: BoxFit.cover,
                                ),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("McCesear's Resturant",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 1.5,),
                                      Text("blah blah blah blah blah blah blah blah blah blah blah blah",style: TextStyle(),overflow: TextOverflow.clip,),
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