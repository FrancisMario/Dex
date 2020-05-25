import 'dart:io';
import 'dart:typed_data';
import 'package:dex/appState.dart';
import 'package:dex/singleVoiceView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound_player.dart';
import 'package:flutter_sound/flutter_sound_recorder.dart';
import 'package:flutter_sound/flauto.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class VoiceMessage extends StatefulWidget {

  @override _VoiceMessage createState()=>_VoiceMessage();

}

class _VoiceMessage extends State<VoiceMessage> {

FlutterSoundRecorder flutterSoundRecorder;
FlutterSoundPlayer flutterSoundPlayer;

  Color startStopBtnColor = Colors.lightBlueAccent;
  var _recorderSubscription;
  var _isPlaying = false;
  var _isRecording = false;
  var recentRecording = "";
  var rec_name = "";
  List<Widget> list = []; 
  File outputFile;
  final uploader = FlutterUploader();
  var  _isControlSectionAdded = false;

  List<Widget> audios = [];

  Future<void>init() async {
     flutterSoundRecorder = await new FlutterSoundRecorder().initialize();
     flutterSoundPlayer = await new FlutterSoundPlayer().initialize();
    
    await flutterSoundRecorder.setDbPeakLevelUpdate(0.8);
    await flutterSoundRecorder.setDbLevelEnabled(true);

  }

  /*
   *  Gets or creates the record folder
   */
  Future<String> getAudioFilesFolder() async{
    //Get this App Document Directory
    final Directory _appDocDir = await getApplicationDocumentsDirectory();

    //App Document Directory + folder name
    final Directory _appDocDirFolder =  Directory('${_appDocDir.path}/Audio/');

     if(await _appDocDirFolder.exists()){ //if folder already exists return path
      return _appDocDirFolder.path;
    }else{//if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  

  }

/// generated unique file name for out order

    Future getUniqueFileName() async { 
      return await DateTime.now().toUtc();
    }


/// Starting recorder

  Future<void> startRecorder() async {

      setState((){
        startStopBtnColor = Colors.greenAccent;
        print("Color changed");
      });
      _isRecording = true;
    // creating file recorder
    var folder = await getAudioFilesFolder();
    var fileName = await getUniqueFileName();

    outputFile = await File ('${folder}/${fileName}.aac');

    recentRecording = outputFile.path;
    Future result = flutterSoundRecorder.startRecorder(uri:outputFile.path ,codec: t_CODEC.CODEC_AAC,);

    result.then((path){
       print('startRecorder: $path');
	      _recorderSubscription = flutterSoundRecorder.onRecorderStateChanged.listen((e) {
	      DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
	      String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
    });
 });
  }

  showMessage(String title, String err){
     showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(err),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: (){
                  Navigator.of(context).pop();
              },
          )
          ],
        );
    }
    
  );
  }

 Future<bool> sendAudio() async {
print("uploading dio");
   Dio dio = new Dio();
    dio.options.baseUrl = "http://34.67.233.153:3000";
    dio.options.connectTimeout = 5000;
    dio.options.method = "post";

    var file = outputFile.path.toString();
    var upload_file = await http.MultipartFile.fromPath("audio", file,);
   FormData formData  = FormData.fromMap({
    "user_id": Provider.of<AppState>(context, listen: false).cred.user_id,
    "file": upload_file,
    });
    var response = await dio.post("/upload", data: formData).timeout(Duration(seconds: 10),onTimeout: (){
      print("uploading timeout");
      showMessage("Error","network error.  check connection and try again!");
    }).then((a){
      
      print("a " + a.statusCode.toString());
      switch (a.statusCode) {
        case 200:
      print("uploading success");
          showMessage("Success","Orders Successfully sent!");
             setState(() {
                  list.add(VoiceView(outputFile:file));
                  outputFile = null;
              });
          break;
        default:
      print("uploading netwoek error");
          showMessage("Error","Sorry there was an issue with our servers. please tr again.");
          break;
      }
    });
}


/// Stopping the recorder
  Future stopRecorder() async{
        setState((){
        startStopBtnColor = Colors.lightBlueAccent;
      });
      Future result =  flutterSoundRecorder.stopRecorder();
      flutterSoundRecorder.savedUri;
      result.then((value) {
	      print('stopRecorder: $value');
        if (_recorderSubscription != null) {
		        _recorderSubscription.cancel();
		        _recorderSubscription = null;
	      }
      });
      _isRecording = false;
  }

// playing recorder
  playRecording() async{
    print("recording: " + recentRecording);
    print("output file: " + outputFile.path);
    Uint8List buffer;
    try{
    Uint8List buffer = (await outputFile.readAsBytesSync())
    	.buffer
    	.asUint8List();
    }catch(e){
      print("error: " + e.toString());
    }
      flutterSoundPlayer.startPlayer(outputFile.path.toString(),whenFinished: (){
        print("i hope you enjoyed the audio");
      });
      _isPlaying = true;
  }

  // stopping playing
  stopPlaying() async {
      await flutterSoundPlayer.stopPlayer();
      setState((){
        startStopBtnColor = Colors.lightBlueAccent;
      });
      _isPlaying = false;
  }
// Releases the sound resources.
  Future<void>dispse(){
    flutterSoundRecorder.release();
    flutterSoundPlayer.release();

  }

  @override void initState() {
    super.initState();
    init();
  }
  @override void dispose() {
    dispse();
    super.dispose();
  }


        
  @override Widget build(BuildContext context) {

    if(!_isControlSectionAdded){
     list.add(bottomControls());
     _isControlSectionAdded = true;
    }
        return Scaffold(
          appBar: AppBar(title: Text("Voice Order"),),
          body: Container(
            // height:20,
            child: Center(
              child: ListView.builder(
                reverse: true,
                itemCount: list.length,
                itemBuilder: (context,index) {
                  return list[index];
                },
             ),
        ),
      ),
    );
  }


    Widget renderVoice(){
      return Container( 
          height: 70,
          width: 100,
              color: Colors.yellow,
              child:Text("Sizes"),
          );
    }

Widget bottomControls() {
     return  Container(
                  height: 50,
                  color: Colors.black12,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[ 
                      Expanded(
                        child:GestureDetector(
                            child: Container(child: Center(child:Text("Send")), ),
                            onTap: () {
                               sendAudio();
                              },
                          ),
                     ),
                
                    Expanded(
                      child:GestureDetector(
                        onTap: () {
                            print("attempting to play: ");
                            print("play btn clicked");
                            print(outputFile.path);
                          if (_isPlaying) {
                            print("stopping player");
                              _isPlaying = false;
                            stopPlaying();
                          }
                          else {
                              _isPlaying = true;
                            print("playing: " + flutterSoundRecorder.savedUri.toString());
                            playRecording();
                          }
                        }
                        , child: Container(child: Center(child:Text("play"+ rec_name)),),
                        ),
                       ),
    
                    Expanded(child: GestureDetector(onTap : () {
                          if (_isRecording) {
                            stopRecorder();
                            print("stopped recording: ");
                          }
                          else {
                            startRecorder();
                            print("started recorder: " + flutterSoundRecorder.savedUri);
                          }
                        },
                        child: Container(color: startStopBtnColor,
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
