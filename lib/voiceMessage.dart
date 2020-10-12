import 'package:dex/listen.dart';
import 'package:dex/voiceSendMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoiceOptions extends StatefulWidget {
  VoiceOptions({Key key}) : super(key: key);
  @override
  _Orders createState() => _Orders();
}

class _Orders extends State<VoiceOptions> {

 

  
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
                Tab(icon: Icon(Icons.my_location),text: "Send",),
                Tab(icon: Icon(Icons.history),text: "Listen",),
              ],
            ),
            ),
  
          body: TabBarView(
            children: [
                VoiceMessage(),
                Listen(),
              ],
          ),
        ),
      ),
    );
  }
}


