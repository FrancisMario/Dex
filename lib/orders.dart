import 'package:dex/history.dart';
import 'package:dex/tracking.dart';
import 'package:dex/voiceMessage.dart';
import 'package:flutter/material.dart';
import 'package:dex/newOrder.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);
  @override
  _Orders createState() => _Orders();
}

class _Orders extends State<Orders> {


  
   static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
    
        primarySwatch: Colors.red,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.new_releases),text: "New",),
                Tab(icon: Icon(Icons.my_location),text: "Track",),
                Tab(icon: Icon(Icons.history),text: "History",),
              ],
            ),
            ),
  
          body: TabBarView(
            children: [
                OrderOptions(),
                Tracking(widget.key),
                History(),
              ],
          ),
        ),
      ),
    );
  }
}

class OrderOptions extends StatelessWidget
 {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Center(
                child: Text("We Support Different Types Orders, You CA",style: TextStyle(fontSize:20),),
             ),
                    Padding(padding: EdgeInsets.only(bottom:20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return NewOrder();}));
              },
            child :Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.tealAccent,
                 ),
              height: 200,
              width: 150,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Icon(Icons.textsms,size: 100,),
                      Text("form",style: TextStyle(fontSize:25),),
                  ],
                ), 
              ),
             ),
            ),
            Padding(padding: EdgeInsets.only(left:10)),


            GestureDetector(
              onTap: (){
                // Redirect to the page
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return VoiceMessage();}));
              },
            child: Container(
               decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.tealAccent,
            ),
              height: 200,
              width: 150,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Icon(Icons.mic,size: 100,),
                      Text("voice",style: TextStyle(fontSize:25),)
                  ],
                ),
              ),
             ),
           ),
          ]
        )
      ],),)
    );
  }

 }
