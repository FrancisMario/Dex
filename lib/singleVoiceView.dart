import 'package:flutter/material.dart';

class VoiceView extends StatefulWidget{

    final String id;

  const VoiceView({Key key, this.id}) : super(key: key);
    
  @override
  _VoiceView createState() => _VoiceView();

}

class _VoiceView extends State<VoiceView>{

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 70,
      width: 4, 
      child: Row(
        children: <Widget>[
            Expanded(
              child: null
            ),
        ],
      ),
    );
  }

  
} 