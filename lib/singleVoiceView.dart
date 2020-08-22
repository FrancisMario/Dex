import 'dart:io';
import 'dart:typed_data';

import 'package:dex/appState.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class VoiceView extends StatefulWidget {
  final String outputFile;
  final String url;
  const VoiceView({Key key, this.outputFile, this.url}) : super(key: key);

  @override
  _VoiceView createState() => _VoiceView();
}

class _VoiceView extends State<VoiceView> {
  String host = '';
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  @override
  void dispose() {
    audioPlayer.release();
    super.dispose();
  }

  bool isPlaying = false;
  bool isPaused = false;

  play() async {
    print('playing');
    isPlaying = true;
    var file = host + widget.url;
    print(file);
     audioPlayer.play(file);

     audioPlayer.onPlayerCompletion.listen((event) {
        setState(() {
        audioPlayer.release();
        isPlaying = false;
        print('Hello ');
        });
      });
  }

  pause() async {
    print('paused');
    isPaused = true;
    int result = await audioPlayer.pause();
    print(result);
  }

  resume() async {
    print('resume');
    isPaused = false;
    int result = await audioPlayer.resume();
    print(result);
  }

  

  @override
  Widget build(BuildContext context) {
    host = Provider.of<AppState>(context, listen: false).serverUrl;
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 0),
      padding: EdgeInsets.only(left: 0),
      height: 70,
      color: Colors.yellow,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(color: Colors.white),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.amber,
              margin: EdgeInsets.all(10),
              child: LinearProgressIndicator(
                value: 10,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Icon(Icons.access_alarm),
              onTap: () {
                print("Hello");
                    play();
                // if (isPlaying) {
                //   if (isPaused) {
                //     resume();
                //   } else {
                //     play();
                //   }
                // } else {
                //   pause();
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}
