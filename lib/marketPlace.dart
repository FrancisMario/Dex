import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar:AppBar(title:Text("Market Place")),
         body: Container(
           margin: EdgeInsets.symmetric(horizontal:5,vertical: 10),
           width: MediaQuery.of(context).size.width - 10,
            child: GridView.count(crossAxisCount: 2, crossAxisSpacing: 1.2, mainAxisSpacing: 1.2,
            physics: BouncingScrollPhysics(),
            children: List.generate(
              widget.data.length, (index) => 
                GestureDetector(
                  onTap: (){

                   },
                  child: Expanded(
                    child: Container(
                      color: Colors.accents[index],
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(widget.data[index]["icon"]),
                                Text(widget.data[index]["name"])
                              ],
                        ),
                     ),
                  ),
                ),
              )
            ),
         ),
       ),
    );
  }
}