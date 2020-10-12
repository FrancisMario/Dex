import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SelectPlan extends StatefulWidget {
  final String _title;

  const SelectPlan(this._title);
  @override
  _SelectPlan createState() => _SelectPlan();
  
}

class _SelectPlan extends State<SelectPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(widget._title),
          ),
          body: Container(
            child: Center(
              child:
                 ListView(
                   physics: BouncingScrollPhysics(),
                  //  scrollDirection: Axis.horizontal,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Padding(padding: EdgeInsets.only(top:10)),
                  Padding(padding: EdgeInsets.only(right:10)),
                  Card("Coporate","","2500", Color.fromRGBO(236, 112, 99, 1),),
                  Padding(padding: EdgeInsets.only(top:10)),
                  Padding(padding: EdgeInsets.only(right:10)),
                  Card("Mid-Range","","2500",Color.fromRGBO(46, 134, 193, 1),),
                  Padding(padding: EdgeInsets.only(top:10)),
                  Padding(padding: EdgeInsets.only(right:10)),
                  Card("Small","","2500",Color.fromRGBO(40, 180, 99, 1),),
                  Padding(padding: EdgeInsets.only(top:10)),
                  Padding(padding: EdgeInsets.only(right:10)),
                  Card("Small","","2500",Color.fromRGBO(40, 180, 99, 1),),
                  Padding(padding: EdgeInsets.only(top:10)),
                  Padding(padding: EdgeInsets.only(right:10)),
                  Card("Small","","2500",Color.fromRGBO(40, 180, 99, 1),),
                  Padding(padding: EdgeInsets.only(right:10)),
                ],
              ),
            ),
          ),
    );
  }
}


class Card extends StatelessWidget {

  var description;
  var price;
  var title;
  Color color;
 
  
  Card(this.title,this.description,this.price,this.color);

  @override
  Widget build(BuildContext context) {
    return Center (
      child:GestureDetector(
        onTap: (){

        },
      child: Container(
        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),
        height: MediaQuery.of(context).size.width / 3.0,
        width: MediaQuery.of(context).size.width / 1.1000000000,
        child: Container(
              padding: EdgeInsets.all(10),
              child: Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Serekunda",style: TextStyle(fontSize:25),),
                            Divider(),
                            Text("Bamboo",style: TextStyle(fontSize:20),),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 1,child: VerticalDivider(),),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("price"),
                          ],
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
          ),
       ),
    );
        
  }
}