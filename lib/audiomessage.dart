import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Audio extends StatefulWidget {
  final Map data;
  Audio({Key key, this.data}) : super(key: key);

  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool playing = false;
  bool paused = false;
  String timer = "0:0";
  @override
  Widget build(BuildContext context) {

  play() async {
    int result = await audioPlayer.play("https://localhost/market/voice/whatsupdanger.mp3");
    if (result == 1) {
      print("playing");
    }
      playing = false;
      setState(() {});
  }
    return Container(
      color:Colors.black87,
      width: MediaQuery.of(context).size.width /1.2,
      height: MediaQuery.of(context).size.height / 7,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: (){
                    play();
              print("shit");
              // playing ? () async {
              //   // if playing but paused or playing but not paused
              //   paused ? () async{
              //     audioPlayer.resume();
              //        paused = false;
              //     } : () async {
              //     audioPlayer.pause();
              //     paused = true;
              //       };
              //   } : () async {
              //       playing = true;
              //       play();
              //       setState(() {});
              //     };
            },
            child: Expanded(
              flex: 1,
              child: Icon(playing ? Icons.pause : Icons.play_circle_filled,size: 60,),
            ),
          ),
          Expanded(
            flex: 2,
            child:Text(timer)
          ),
          Expanded(
            flex: 1,
            child:Container(
              
            )
          ),
        ],
      ),
    );
  }
}
