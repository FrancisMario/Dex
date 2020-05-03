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
                   scrollDirection: Axis.horizontal,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Padding(padding: EdgeInsets.only(top:10)),
                  Padding(padding: EdgeInsets.only(right:10)),
                  PlanCard("Coporate","","2500", Color.fromRGBO(236, 112, 99, 1),),
                  Padding(padding: EdgeInsets.only(top:10)),
                  Padding(padding: EdgeInsets.only(right:10)),
                  PlanCard("Mid-Range","","2500",Color.fromRGBO(46, 134, 193, 1),),
                  Padding(padding: EdgeInsets.only(top:10)),
                  Padding(padding: EdgeInsets.only(left:10)),
                  Padding(padding: EdgeInsets.only(right:10)),
                  PlanCard("Small","","2500",Color.fromRGBO(40, 180, 99, 1),),
                  Padding(padding: EdgeInsets.only(right:10)),
                ],
              ),
            ),
          ),
    );
  }
}


class PlanCard extends StatelessWidget {

  var description;
  var price;
  var title;
  Color color;
 
  
  PlanCard(this.title,this.description,this.price,this.color);

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
        height: 350,
        width: 200,
        child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children:<Widget>[
                Padding(padding: EdgeInsets.only(top:20)),
                Text(title,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.only(top:10)),
                Text(description,style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.only(top:40)),
                Text(price,style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.only(top:20)),
                Text("/Month",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.only(top:20)),


                    FlatButton(onPressed: (){
                      // if(_confirmCodeFormKey.currentState.validate()){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return ();}));
                      // } 
                    }, child: Container(
                      height: 50,
                      width: 300,
                      decoration: new BoxDecoration(
                        color: Color.fromRGBO(250, 219, 216,1),
                        borderRadius: new BorderRadius.circular(5)
                      ),
                      child: new Center(
                        child:Text('Select',
                           style: new TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ),
                    ),
                ]
                )
              ),
          ),
       ),
    );
        
  }
}