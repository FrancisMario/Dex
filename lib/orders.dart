import 'package:dex/history.dart';
import 'package:dex/tracking.dart';
import 'package:dex/voiceSendMessage.dart';
import 'package:flutter/material.dart';
import 'package:dex/newOrder.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.my_location),text: "Track",),
                Tab(icon: Icon(Icons.history),text: "History",),
              ],
            ),
            ),
  
          body: TabBarView(
            children: [
                Tracking(key:widget.key),
                History(),
              ],
          ),
        ),
      ),
    );
  }
}


