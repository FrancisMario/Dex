import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class History extends StatefulWidget {

  const History();
  @override
  _History createState() => _History();
  
}

class _History extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          
          body: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                    Padding(padding: EdgeInsets.only(top:20)),
                    HistoryView("02-03-20","Mario Gomez","Monthly"),
                    Padding(padding: EdgeInsets.only(top:20)),
                    HistoryView("02-03-20","Mario Gomez","Monthly"),
                    Padding(padding: EdgeInsets.only(top:20)),
                    HistoryView("02-03-20","Mario Gomez","Monthly"),
                ],
              ),
            ),
          ),


    );
  }
}


class HistoryView extends StatelessWidget {

  final String date;
  final String reciever;
  final String title;
  // final Color color;
 
  
  HistoryView(this.date,this.title,this.reciever);

  @override
  Widget build(BuildContext context) {
    return Center (
      child:GestureDetector(
        onTap: (){

        },
      child: Container(
        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blueGrey,
            ),
        // height: 100,
        child: Container(
              width: 350,
              padding: EdgeInsets.all(10),
              child: Row(
                children:<Widget>[
                Padding(padding: EdgeInsets.only(top:20)),
                Expanded(
                  child:  Center(
                  child: Column(children:<Widget>[
                     Padding(padding: EdgeInsets.only(top:20)),
                      Text("Date",style: TextStyle(fontSize:20),),
                        Padding(padding: EdgeInsets.only(top:10)),
                       Text( date ,style: TextStyle(fontSize:20),),

                      ],
                     ),
                    ),
                   ),
                

                Expanded(
                  child:  Center(
                  child: Column(children:<Widget>[
                     Padding(padding: EdgeInsets.only(top:20)),
                      Text("title",style: TextStyle(fontSize:20),),
                        Padding(padding: EdgeInsets.only(top:10)),
                       Text( title ,style: TextStyle(fontSize:20),),

                      ],
                     ),
                    ),
                   ),

                   Expanded(
                  child:  Center(
                  child: Column(children:<Widget>[
                     Padding(padding: EdgeInsets.only(top:20)),
                      Text("Reciever",style: TextStyle(fontSize:20),),
                        Padding(padding: EdgeInsets.only(top:10)),
                       Text( reciever ,style: TextStyle(fontSize:20),),

                      ],
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