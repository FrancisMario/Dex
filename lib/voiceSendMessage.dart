import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flauto.dart';
import 'package:flutter_sound/flutter_sound_player.dart';
import 'package:flutter_sound/flutter_sound_recorder.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import 'package:dex/appState.dart';
import 'package:dex/singleVoiceView.dart';

class VoiceMessage extends StatefulWidget {
  @override
  _VoiceMessage createState() => _VoiceMessage();
}

class _VoiceMessage extends State<VoiceMessage> {
  FlutterSoundRecorder flutterSoundRecorder;
  FlutterSoundPlayer flutterSoundPlayer;

  Color startStopBtnColor = Colors.lightBlueAccent;
  var loaded = false;
  var recording = false;
  var sendable = false; // wether the send is posible right now.   
  var _recorderSubscription;
  var _isPlaying = false;
  var _isRecording = false;
  var recentRecording = "";
  var rec_name = "";
  var record_time = "00:00";
  List<Widget> list = [];
  File outputFile;
  final uploader = FlutterUploader();
  var _isControlSectionAdded = false;

  List<Widget> audios = [];

  Future<void> init() async {
    flutterSoundRecorder = await new FlutterSoundRecorder().initialize();
    flutterSoundPlayer = await new FlutterSoundPlayer().initialize();

    await flutterSoundRecorder.setDbPeakLevelUpdate(0.8);
    await flutterSoundRecorder.setDbLevelEnabled(true);
  }

  /*
   *  Gets or creates the record folder
   */
  Future<String> getAudioFilesFolder() async {
    //Get this App Document Directory
    final Directory _appDocDir = await getApplicationDocumentsDirectory();

    //App Document Directory + folder name
    final Directory _appDocDirFolder = Directory('${_appDocDir.path}/Audio/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

// generated unique file name for out order

  Future getUniqueFileName() async {
    return await DateTime.now().toUtc();
  }

  /// Starting recorder

  Future<void> startRecorder() async {
    if(!recording){ 
    setState(() {
      print("Color changed");
      recording = true;
          });
    // creating file recorder
    var folder = await getAudioFilesFolder();
    var fileName = await getUniqueFileName();

    outputFile = await File('${folder}/${fileName}.aac');

    recentRecording = outputFile.path;
    Future result = flutterSoundRecorder.startRecorder(
      uri: outputFile.path,
      codec: t_CODEC.CODEC_AAC,
    );

    result.then((path) {
      print('startRecorder: $path');
      _recorderSubscription =
          flutterSoundRecorder.onRecorderStateChanged.listen((e) {
        DateTime date =
            new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
      });
    });
    } else {
      stopRecorder();
    }
  }

  showMessage(String title, String err) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(err),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<bool> sendAudio() async {
    if(sendable){
      
    print("response.statusCode");
    Dio dio = new Dio();
     String url = Provider.of<AppState>(context, listen: false).serverUrl;
    // String user_id = Provider.of<AppState>(context, listen: false).cred.user_id;
    String user_id = "d430917dcefc1012993a98a403678141";
   var formData =  FormData.fromMap({
    "user_id": user_id,
    "audio": await MultipartFile.fromFile(outputFile.path ,filename: "audio"),
});
    print("rec_name");
    print(outputFile);
    var response = await dio.post(url + "sendAudio.php", data: formData);
    print("response.statusCode");
    print(url);
    print(response.statusCode);
    print(response.data);
    if(response.statusCode == 200){
      showMessage("Success","The message was successfully sent, our agents will get back to you shortly");
    } else {
      showMessage("Error","There was an Error, please try again");
    }
    sendable = false;
    loaded = false;
    } else {

    }
  }

  /// Stopping the recorder
  Future stopRecorder() async {
    Future result = flutterSoundRecorder.stopRecorder();
    flutterSoundRecorder.savedUri;
    result.then((value) {
      print('stopRecorder: $value');
      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
    });
    setState(() {
     recording = false;
     loaded = true;
     sendable = true;

    });
  }

// playing recorder
  playRecording() async {
    if(!_isPlaying){
    print("recording: " + recentRecording);
    print("output file: " + outputFile.path);
    // Uint8List buffer;
    // try{
    Uint8List buffer =
        (await outputFile.readAsBytesSync()).buffer.asUint8List();
    // }catch(e){
    //   print("error: " + e.toString());
    // }
    flutterSoundPlayer.startPlayerFromBuffer(buffer, whenFinished: () {
      print("i hope you enjoyed the audio");
    _isPlaying = false;
    }).catchError((err) {
      print("sorry about the error");
      print(err);
      print("sorry about the error");
    });
    _isPlaying = true;
    } else {
      flutterSoundPlayer.pausePlayer();
    }
  }

  // stopping playing
  stopPlaying() async {
    await flutterSoundPlayer.stopPlayer();
    setState(() {
      startStopBtnColor = Colors.lightBlueAccent;
    });
    _isPlaying = false;
  }

// Releases the sound resources.
  Future<void> dispse() {
    flutterSoundRecorder.release();
    flutterSoundPlayer.release();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    dispse();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isControlSectionAdded) {
      list.add(bottomControls());
      _isControlSectionAdded = true;
    }
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Voice Order"),
        // ),
        body: recordStudio()
        //     Container(
        //       // height:20,
        //       child: Center(
        //         child: ListView.builder(
        //           reverse: true,
        //           itemCount: list.length,
        //           itemBuilder: (context,index) {
        //             return list[index];
        //           },
        //        ),
        //   ),
        // ),
        );
  }

  Widget renderVoice() {
    return Container(
      height: 70,
      width: 100,
      color: Colors.yellow,
      child: Text("Sizes"),
    );
  }

  Widget recordStudio() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    print("sending");
                    sendAudio();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Icon(Icons.send, size: 50, semanticLabel: "send"),
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            color: loaded ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      Text("Send")
                    ],
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                GestureDetector(
                  onTap: () {
                    print("recording");
                    startRecorder();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Icon(Icons.mic, size: 100, semanticLabel: "Hello"),
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            color: recording ? Colors.red : Colors.green,
                            borderRadius: BorderRadius.circular(75)),
                      ),
                      Text("00:00")
                    ],
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                GestureDetector(
                  onTap: () {
                    print("playing recording");
                    playRecording();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.play_arrow,
                          size: 50,
                          semanticLabel: "play",
                        ),
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            color: loaded ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      Text("Play")
                    ],
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomControls() {
    return Container(
      height: 50,
      color: Colors.black12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                child: Center(child: Text("Send")),
              ),
              onTap: () {
                sendAudio();
                print("sending");
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                print("attempting to play: ");
                print("play btn clicked");
                print(outputFile.path);
                if (_isPlaying) {
                  print("stopping player");
                  _isPlaying = false;
                  stopPlaying();
                } else {
                  _isPlaying = true;
                  print("playing: " + flutterSoundRecorder.savedUri.toString());
                  playRecording();
                }
              },
              child: Container(
                child: Center(child: Text("play" + rec_name)),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_isRecording) {
                  stopRecorder();
                  print("stopped recording: ");
                } else {
                  startRecorder();
                  print("started recorder: " + flutterSoundRecorder.savedUri);
                }
              },
              child: Container(
                color: startStopBtnColor,
                height: 100,
                child: Icon(Icons.mic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
