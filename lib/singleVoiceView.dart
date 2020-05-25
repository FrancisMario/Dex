import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound_player.dart';

class VoiceView extends StatefulWidget{

    final String outputFile;

  const VoiceView({Key key, this.outputFile,}) : super(key: key);
    
  @override
  _VoiceView createState() => _VoiceView();

}

class _VoiceView extends State<VoiceView>{
  var controller;
  bool isPlaying = false;
  bool isPaused;
  FlutterSoundPlayer flutterSoundPlayer = new FlutterSoundPlayer();
  IconData play = Icons.play_circle_outline;
  IconData pause = Icons.pause_circle_outline;
  IconData icon;


   @override void initState()  {
     flutterSoundPlayer.initialize();
      super.initState();
  }
  @override void dispose() {
    flutterSoundPlayer.release();
    super.dispose();
  }


  startPlayer() async { 
      flutterSoundPlayer.startPlayer(widget.outputFile.toString(),whenFinished: (){
        print("i hope you enjoyed the audio");
      });
  }

 

  pausePlayer(){
      flutterSoundPlayer.pausePlayer();
      icon = play;
  }

  resumePlayer(){
      flutterSoundPlayer.resumePlayer();
      icon = pause;
  }

  @override
  Widget build(BuildContext context) {
   icon = play;
    return Container(
              margin: EdgeInsets.only(bottom: 10,left:0), 
              padding: EdgeInsets.only(left:0),               
              height: 70,
              color: Colors.yellow,
              child:Row(
                children: <Widget>[
                    Expanded(flex:1, child: Container(color: Colors.white),),
                    Expanded(flex:4, child: Container(color: Colors.amber,),),
                    Expanded(flex:1,
                    child: GestureDetector(
                      child: Icon(icon),
                        onTap: (){
                          if (!isPlaying) {
                            startPlayer();
                            setState(() {
                                isPaused = false;
                                isPlaying = true;
                                icon = pause;
                              });
                          } else {
                            if (!isPaused) {
                              pausePlayer();
                              setState(() {
                                isPaused = true;
                                icon = play;
                              });
                            } else {
                              resumePlayer(); 
                              setState(() {
                                isPaused = false;
                                icon = pause;
                              });
                            }
                          }
                        },  
                      ),
                    ),
                ],
              ),
          );
  }

  
} 